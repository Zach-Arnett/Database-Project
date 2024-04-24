//---------- Order Confirmation ----------
// Get "Place Order" button
var confirm_button_ME = document.getElementById('ME-order-button'); // Meal Exchange
var confirm_button_DB = document.getElementById('DB-order-button'); // Declining Balance
var confirm_button_CR = document.getElementById('CR-order-button'); // Credit / Debit
var submit_info_CR = document.getElementById('submit-info'); // Credit / Debit
// Get the confirmation menu to be displayed
var confirmation_menu = document.getElementById('confirmation-menu');
var credit_form = document.getElementById('credit-form');

// Confirm Order Function
function confirmOrder() {
    credit_form.classList.add("hidden");
    confirmation_menu.classList.remove("hidden");
}
function confirmOrderCredit() {
    credit_form.classList.remove("hidden");
}
// Handle clicking on "Place Order" button
if (confirm_button_ME) { confirm_button_ME.addEventListener("click", function() { confirmOrder(); });};
if (confirm_button_DB) { confirm_button_DB.addEventListener("click", function() { confirmOrder(); });};
if (confirm_button_CR) { confirm_button_CR.addEventListener("click", function() { confirmOrderCredit(); });};
if (submit_info_CR) { submit_info_CR.addEventListener("click", function() { confirmOrder(); });};
