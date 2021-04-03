# Terraform S3/CloudFront/Route53 :sunglasses:

- Learning Terraform to deploying a site in AWS Cloud using s3 bucket, cloud front and route53

## Give a Star! :star:

If you liked the project, please give a star ;)

## You need some of the fallowing tools :exclamation:

-  Terraform
-  AWS Account

## Description :books:

Static websites deliver HTML, JavaScript, images, video and other files to your website visitors, and contain no application code. They are best for sites with few authors and relatively infrequent content changes, typically personal and simple marketing websites. Static websites are very low cost, provide high-levels of reliability, require almost no IT administration, and scale to handle enterprise-level traffic with no additional work.

### AWS S3 Bucket ✔️

Amazon S3 provides secure, durable, and highly-scalable cloud storage for the objects that make up your static website. Examples of objects you can store include HTML pages, CSS files, images, videos, and JavaScript. Amazon S3 makes it easy to use object storage with a simple web interface to store and retrieve data from anywhere on the web, meaning that your website will be reliably available to your visitors.

How Pricing Works: Amazon S3 Pricing is based on five types of usage: the type of Amazon S3 storage you use, where you store your website content (e.g. US East vs. Asia Pacific - Sydney), the amount you store, the number of requests you or your users make to store new content or retrieve the content, and the amount of data that is transferred from Amazon S3 to you or your users. Since you’ll deliver content with Amazon CloudFront, your Amazon S3 costs will be based on storage.

- Example: Using Standard Storage in US East, if you store 5GB of content, you’d pay $0.15 per month. If you created your account in the past 12 months and you’re eligible for the AWS Free Tier, you’d pay $0.00 per month.

### AWS Route 53 ✔️

Amazon Route 53 is a highly available and scalable cloud Domain Name System (DNS) web service. It is designed to give you a reliable and cost-effective way to route end users to Internet applications by translating a domain name (like www.yourwebsite.com) into the numeric IP addresses (e.g., 192.0.2.1) that computers use to connect to each other.  When someone visits your website, Amazon Route 53 will manage this domain name to IP address relationship this in a Hosted Zone.

How Pricing Works: Amazon Route53 pricing is based on three things: the number of domain names managed (paid annually), the number of Hosted Zones you use, and the number of end user queries for your website. 

- Example: For a static website you’ll register one domain and use one Hosted Zone. All queries to Amazon S3-based static websites are free. The cost to register a domain varies by the top level domain you want to register. For example, “.com” is $12 annually and “.net” is $11 annually. For a list of all domain prices, see Amazon Route 53 Domain Name Pricing. The hosted zone for your site will cost $0.50 per month.


### AWS CloudFront ✔️

Amazon CloudFront is a global Content Delivery Network (CDN), which will host your website on a global network of edge servers, helping users load your website more quickly. When requests for your website content come through, they are automatically routed to the nearest edge location, closest to where the request originated from, so your content is delivered to your end user with the best possible performance.

How Pricing Works: Amazon CloudFront pricing is based on the three things: the amount of data you transfer to your end users, the number of user requests (for both http and https content), and the CloudFront locations you use (which will depend on the global diversity of your users).

- Example: Let’s say your website uses CloudFront for a month (30 days), and the site has 1,000 visitors each day for that month. Each visitor clicked 1 page that returned a single object (1 request) and they did this once each day for 30 days. Turns out each request is 1MB for the amount of data transferred, so in total for the month that comes to 30,000MB or 29GB (1GB = 1,024MB). Half the requests are from the US and half are from Europe, so your monthly total for data transferred comes to $2.47. Also, each click is an HTTP request, so for the month that equals 30,000 HTTP requests, which comes to a total of $0.02 for the month. Adding the two values together, the total cost for using CloudFront for this example would be $2.49 for the month.

If you created your account in the past 12 months, you are eligible for the AWS Free Tier. With AWS Free Tier, the first 50GB of data transferred out and the first 2,000,000 HTTP/HTTPS requests are free so for this example, your bill for the month would be reduced to $0.00.
