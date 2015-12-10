This program uses Matlab to detect coins and extract the feature of the coin.
It uses a C++ program to train a neural network.


**How to run this program:**

1. To run all the sample images:  
  Please run `test.m` to test the program on all the sample images under folder `test-images` on Mac / Linux platform:

        >> test

2. To run one specific sample images:  
  Please run `main.m` with image file name as parameter to test the program on one sample image under folder `test-images` on Mac / Linux platform.  For example:

        >> main('test-images/all_nickel_30c.jpg');


  Below is a sample of output in the command window:

        Testing program on image 70c.jpg
        Please wait while we are processing the image.
        Computing background mask.
        Separating pennies from other types of coin.
        There is no penny in the image.
        There are 4 coins of other type in the image.
        There are more than one type of coin in the image, then use radius ratio to decide the coin type.
        The total is 70 cents.
        Please press enter to proceed to the next image.