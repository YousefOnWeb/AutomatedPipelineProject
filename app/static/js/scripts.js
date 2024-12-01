document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");

    form.addEventListener("submit", function (event) {
        // Example client-side interactivity
        const inputField = document.querySelector("input[name='input_text']");
        if (!inputField.value.trim()) {
            alert("Please enter some text!");
            event.preventDefault(); // Prevent form submission if input is empty
        }
    });
});
