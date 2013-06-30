ruby-sdk
========
The source for a ruby gem containing the Jana API SDK, along with a simple example of using that SDK in rails 3.

To use the example,you will first need to build and install the gem, using the provided gemspec.

Then you should be able to start the rails server, and hit the default page to retrieve JIA links. You will probably need to customize app/controllers/jia_controller.rb to specify your customerId, secretKey, offerId, and the url of the Jana server you will be hitting (the values in the example are from a development server). 