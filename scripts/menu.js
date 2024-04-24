/* Food Menu Javascript */

// Toggles showing/hiding the ingredients of an item
var toggleButtons = document.querySelectorAll('.ingredient-toggle');
toggleButtons.forEach(function(button) {
    button.addEventListener('click', function() {
        // Toggle the 'hidden' class of next sibling element (ingredient info)
        var ingredientsList = button.nextElementSibling;
        ingredientsList.classList.toggle('hidden');
    });
});


// Make it so the user isn't returned to the top of the page every time they select an item
// Store scroll position in localStorage
function storeScrollPosition() {
    localStorage.setItem('scrollPosition', window.scrollY);
}
// Restore scroll position from localStorage
function restoreScrollPosition() {
    var scrollPosition = localStorage.getItem('scrollPosition');
    if (scrollPosition !== null) {
        window.scrollTo(0, scrollPosition);
        localStorage.removeItem('scrollPosition'); // Clear the stored scroll position
    }
}
// Call restoreScrollPosition function when the page loads
document.addEventListener('DOMContentLoaded', function() { restoreScrollPosition(); });
// Call storeScrollPosition function when a form is submitted
document.addEventListener('submit', function() { storeScrollPosition(); });

