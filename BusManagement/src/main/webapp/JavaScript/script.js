document.getElementById("bookingForm").addEventListener("submit", function (e) {
    e.preventDefault(); // Prevent form submission

    // Collect user input
    const route = document.getElementById("route").value;
    const date = document.getElementById("date").value;
    const seat = document.getElementById("seat").value;

    // For now, just log the data
    console.log(`Route: ${route}, Date: ${date}, Seat: ${seat}`);

    // Show confirmation alert
    alert("Your ticket has been booked successfully!");
});
