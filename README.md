# exer6

Menu and Navigation

# Task
Modify the handout code to implement a checkout function. The checkout screen displays the cart contents, the price for each item, then the total. A button will be available if there are contents in the cart that allows the user to pay for the items. Otherwise, a prompt should be printed that there are no items. Prompt must appear in the snackbar for a successful transaction.

# Approach
I started by copying the code from the handout, then added a Checkout.dart to the screen folder and registered the route in main.dart. The Checkout.dart mimics the code of the MyCart.dart screen. I heavily modified the functions existing from the provided MyCart.dart code to fit the specs, though essentially it was just listeners being told to update, and if there were no contents to the cart just print the prompts. The button to pay also sends a message using the SnackbarMessenger whose message shows in the snackbar.

# Challenges
This was significantly easier than the previous exercise, the biggest challenge here was with the UI. Other than that, it was easy to implement, especially with the provided template.

