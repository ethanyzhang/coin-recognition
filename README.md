# Coin Recognition

Given an input image file having several coins on a solid background, this program will detect those coins and their
denominations then tell you how much money is there in the image.  
Artificial neural network is used when there is only one type of coin in the image.

The main part of the program is written in Matlab, the artificial neural network part is written in C++.

**How to run this program:**

1. To run all the sample images:  
  Please run `test.m` to test the program on all the sample images under folder `test-images` on Mac / Linux platform:

        >> test

2. To run one specific sample images:  
  Please run `main.m` with image file name as parameter to test the program on one sample image under folder `test-images` on Mac / Linux platform.  For example:

        >> main('test-images/70c.jpg');

  Please note that the following image files contain only one type of coin. When they are passed to the program, we will use our artificial nerual network to process them:
  * all_dimes_40c.jpg
  * all_nickel_30c.jpg
  * all_quarter_100c.JPG
  * all_quarter_100c_2.JPG

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