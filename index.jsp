<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pincode Lookup</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <div class="container">
        <h2 class="mt-5">Pincode Lookup</h2>

        <div class="mb-3">
            <label for="pincode" class="form-label">Enter Pincode</label>
            <input type="text" class="form-control" id="pincode" name="pincode" required>
            <span id="loading" style="display: none; color: blue;">Fetching details...</span>
        </div>

        <!-- State and City Fields Always Visible -->
        <div class="mb-3">
            <label for="state" class="form-label">State</label>
            <input type="text" id="state" class="form-control" readonly>

            <label for="city" class="form-label mt-3">City</label>
            <select id="city" class="form-control"></select>
        </div>

        <!-- Result Section -->
        <div id="result" class="mt-4"></div>
    </div>

    <script>
        $(document).ready(function() {
            $("#pincode").on("input", function() {
                var pincode = $(this).val().trim();

                if (pincode.length === 6) {
                    $("#loading").show(); // Show loading text

                    $.ajax({
                        url: 'http://localhost:8059/api/getPincodeDetails',
                        type: 'POST',
                        data: { pincode: pincode },
                        beforeSend: function() {
                            $("#result").html(""); // Clear previous results
                        },
                        success: function(response) {
                            $("#loading").hide(); // Hide loading text

                            if (response && response.length > 0) {
                                var state = response[0].state;
                                $("#state").val(state);

                                var cityDropdown = $("#city");
                                cityDropdown.empty();

                                response.forEach(function(entry) {
                                    cityDropdown.append(
                                        $("<option></option>").text(entry.district).val(entry.district)
                                    );
                                });

                                var resultHTML = "<h3>Details for Pincode: <strong>" + pincode + "</strong></h3>";
                                resultHTML += "<strong>State:</strong> <span style='font-weight: bold;'>" + state + "</span><br/>";
                                resultHTML += "<strong>Cities:</strong> " + response.map(entry => "<span style='font-weight: bold;'>" + entry.district + "</span>").join(", ");

                                $("#result").html(resultHTML);
                            } else {
                                $("#result").html("<strong>No details found for the entered pincode.</strong>");
                                $("#state").val("");
                                $("#city").empty();
                            }
                        },
                        error: function() {
                            $("#loading").hide();
                            $("#result").html("<strong style='color: red;'>Error fetching details. Please try again.</strong>");
                            $("#state").val("");
                            $("#city").empty();
                        }
                    });
                } else {
                    $("#result").html("");
                    $("#state").val("");
                    $("#city").empty();
                }
            });
        });
    </script>
</body>
</html>
