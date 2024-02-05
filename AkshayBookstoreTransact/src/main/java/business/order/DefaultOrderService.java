package business.order;

import api.ApiException;
import business.BookstoreDbException;
import business.JdbcUtils;
import business.book.Book;
import business.book.BookDao;
import business.cart.ShoppingCart;
import business.cart.ShoppingCartItem;
import business.customer.Customer;
import business.customer.CustomerDao;
import business.customer.CustomerForm;
import com.fasterxml.jackson.datatype.jsr310.deser.YearDeserializer;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DateTimeException;
import java.time.YearMonth;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

public class DefaultOrderService implements OrderService {

	private BookDao bookDao;
	private OrderDao orderDao;
	private LineItemDao lineItemDao;
	private CustomerDao customerDao;

	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}

	public void setLineItemDao(LineItemDao lineItemDao) {
		this.lineItemDao = lineItemDao;
	}

	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	public void setBookDao(BookDao bookDao) {
		this.bookDao = bookDao;
	}

	@Override
	public OrderDetails getOrderDetails(long orderId) {
		Order order = orderDao.findByOrderId(orderId);
		Customer customer = customerDao.findByCustomerId(order.customerId());
		List<LineItem> lineItems = lineItemDao.findByOrderId(orderId);
		List<Book> books = lineItems
				.stream()
				.map(lineItem -> bookDao.findByBookId(lineItem.bookId()))
				.toList();
		return new OrderDetails(order, customer, lineItems, books);
	}

	private Date getCardExpirationDate(String monthString, String yearString) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Integer.parseInt(yearString), Integer.parseInt(monthString) - 1, 1); // Java months are zero-based, so we subtract 1 from the input month
		int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		calendar.set(Calendar.DAY_OF_MONTH, lastDay);
		Date ccExpDate = calendar.getTime();
		return ccExpDate;
	}

	@Override
    public long placeOrder(CustomerForm customerForm, ShoppingCart cart) {

		validateCustomer(customerForm);
		validateCart(cart);

		// NOTE: MORE CODE PROVIDED NEXT PROJECT

		try (Connection connection = JdbcUtils.getConnection()) {
			Date ccExpDate = getCardExpirationDate(
					customerForm.getCcExpiryMonth(),
					customerForm.getCcExpiryYear());
			return performPlaceOrderTransaction(
					customerForm.getName(),
					customerForm.getAddress(),
					customerForm.getPhone(),
					customerForm.getEmail(),
					customerForm.getCcNumber(),
					ccExpDate, cart, connection);
		} catch (SQLException e) {
			throw new BookstoreDbException("Error during close connection for customer order", e);
		}

	}


	private long performPlaceOrderTransaction(
			String name, String address, String phone,
			String email, String ccNumber, Date date,
			ShoppingCart cart, Connection connection) {
		try {
			connection.setAutoCommit(false);
			long customerId = customerDao.create(
					connection, name, address, phone, email,
					ccNumber, date);

			long customerOrderId = orderDao.create(
					connection,
					cart.getComputedSubtotal() + cart.getSurcharge() + cart.getShippingCost(),
					generateConfirmationNumber(), customerId);
			for (ShoppingCartItem item : cart.getItems()) {
				lineItemDao.create(connection, customerOrderId,
						item.getBookId(), item.getQuantity());
			}
			connection.commit();
			return customerOrderId;
		} catch (Exception e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				throw new BookstoreDbException("Failed to roll back transaction", e1);
			}
			return 0;
		}
	}

	private int generateConfirmationNumber() {
		return ThreadLocalRandom.current().nextInt(999999999);
	}

	private void validateCustomer(CustomerForm customerForm) {

    	String name = customerForm.getName();
		String address = customerForm.getAddress();
		String phNumber = customerForm.getPhone();
		String email = customerForm.getEmail();
		String ccNumber = customerForm.getCcNumber();
		String ccExpiryMonth = customerForm.getCcExpiryMonth();
		String ccExpiryYear = customerForm.getCcExpiryYear();


		if (name == null || name.equals("") || name.length() > 45 || name.length() < 4) {
			throw new ApiException.ValidationFailure("Name","Invalid name field");
		}

		// TODO: Validation checks for address, phone, email, ccNumber

		if (address == null || address.equals("") || address.length() > 45 || address.length() < 4){
			throw new ApiException.ValidationFailure("Address","Invalid address field");
		}

		if (phNumber == null || phNumber.equals("")){
			throw new ApiException.ValidationFailure("Phone Number","Invalid phone number field");
		}

		phNumber = phNumber.replaceAll("[^0-9]", "");

		if(phNumber.length()!=10)
			throw new ApiException.ValidationFailure("Phone Number","Invalid phone number field");

		if (email == null || email.equals("") || email.contains(" ") || characterCount(email)!=1 || email.charAt(email.length() - 1) == '.'){
			throw new ApiException.ValidationFailure("Email","Invalid email field");
		}

		if (ccNumber == null || ccNumber.equals("")){
			throw new ApiException.ValidationFailure("Credit card","Invalid Credit card number field");
		}

		ccNumber = ccNumber.replaceAll("[^0-9]", "");

		if(ccNumber.length()<14 || ccNumber.length()>16)
			throw new ApiException.ValidationFailure("Credit Card","Invalid Credit card number field");

		if (expiryDateIsInvalid(ccExpiryMonth, ccExpiryYear)) {
			throw new ApiException.ValidationFailure("Please enter a valid expiration date.");

		}
	}

	private int characterCount(String email) {
		return (int) email.chars().filter(ch -> ch == '@').count();
	}

	private boolean expiryDateIsInvalid(String ccExpiryMonth, String ccExpiryYear) {

		try {
			int month = Integer.parseInt(ccExpiryMonth);
			int year = Integer.parseInt(ccExpiryYear);
			// TODO: return true when the provided month/year is before the current month/yeaR
			// HINT: Use Integer.parseInt and the YearMonth class
			YearMonth currentDate = YearMonth.now();
			YearMonth ccDate = YearMonth.of(year, month);

			return ccDate.isBefore(currentDate);
		}
		catch (Exception e){
			return true;
		}
	}

	private void validateCart(ShoppingCart cart) {

		if (cart.getItems().size() <= 0) {
			throw new ApiException.ValidationFailure("Cart is empty.");
		}

		cart.getItems().forEach(item-> {
			if (item.getQuantity() <= 0 || item.getQuantity() > 99) {
				throw new ApiException.ValidationFailure("Invalid quantity for "+item.getBookForm().getTitle());
			}
			Book databaseBook = bookDao.findByBookId(item.getBookId());
			int bookPrice = databaseBook.price();
			long categoryId = databaseBook.categoryId();

			if(item.getBookForm().getPrice() != bookPrice)
				throw new ApiException.ValidationFailure("Invalid price for "+item.getBookForm().getTitle());
			if(item.getBookForm().getCategoryId() != categoryId)
				throw new ApiException.ValidationFailure("Invalid category name for "+item.getBookForm().getTitle());
			// TODO: complete the required validations
		});
	}

}
