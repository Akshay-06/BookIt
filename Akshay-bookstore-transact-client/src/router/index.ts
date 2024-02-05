import {createRouter, createWebHistory} from "vue-router";
// @ts-ignore
import HomeView from "../views/HomeView.vue";
// @ts-ignore
import CategoryView from "@/views/CategoryView.vue";
// @ts-ignore
import CartView from "@/views/CartView.vue";
// @ts-ignore
import CheckoutView from '@/views/CheckoutView.vue';
// @ts-ignore
import ConfirmationView from "@/views/ConfirmationView.vue";
// @ts-ignore
import NotFound from "@/views/NotFound.vue";

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: "/AkshayBookstoreTransact",
            name: "home",
            component: HomeView,
            alias: ["/", "/AkshayBookstoreTransact/index.html", "/AkshayBookstoreTransact/home"],
        },
        {
            path: "/AkshayBookstoreTransact/category",
            redirect: "/AkshayBookstoreTransact/category/Best Sellers",
        },
        {
            path: "/AkshayBookstoreTransact/category/:categoryName",
            name: "category-view",
            component: CategoryView,
            props: true,
        },
        {
            path: "/AkshayBookstoreTransact/cart",
            name: "cart-view",
            component: CartView,
        },
        {
            path: "/AkshayBookstoreTransact/checkout",
            name: "checkout-view",
            component: CheckoutView,
        }, {
            path: "/AkshayBookstoreTransact/confirmation",
            name: "confirmation-view",
            component: ConfirmationView,
        }, {
            path: "/AkshayBookstoreTransact/:pathMatch(.*)*",
            name: "not-found",
            component: NotFound,
        },
    ],
});

export default router;
