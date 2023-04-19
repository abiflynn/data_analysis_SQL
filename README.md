# data_driven_businesses_SQL

**Data-Driven Businesses with SQL**

**1.	Project Objectives & Overview**

**1.1	Business Problem** 

Eniac is an online marketplace specialising in Apple-compatible accessories. It was founded 10 years ago in Spain, and it has since grown and expanded. Since the company went public, the investors have been pushing the company to scale up the business and become a big e-commerce player globally. 

Eniac is exploring an expansion to the Brazilian market. Data shows that Brazil has an eCommerce revenue like that of Spain and Italy: an already huge market with an even bigger potential for growth. The problem for Eniac is the lack of knowledge of such a market. The company doesn’t have ties with local providers, package delivery services, or customer service agencies. Creating these ties and knowing the market would take a lot of time, while the board of directors has demanded the expansion to happen within the next year.

Magist is a Brazilian Software as a Service company that offers a centralised order management system to connect small and medium-sized stores with the biggest Brazilian marketplaces. Magist is already a big player and allows small companies to benefit from its economies of scale.

In Brazil, Eniac is considering signing a 3-year contract with Magist and operating through external marketplaces as an intermediate step, while it tests the market, creates brand awareness, and explores the option of opening its own Brazilian marketplace.

The economic conditions of the deal are already being discussed. But not everyone in the company is happy moving on with this. There are two main concerns:
1.	Eniac’s catalogue is 100% tech products, and heavily based on Apple-compatible accessories. It is not clear that the marketplaces Magist works with are a good place for these high-end tech products.
2.	Among Eniac’s efforts to have happy customers, fast deliveries are key. The delivery fees resulting from Magist’s deal with the public Post Office might be cheap, but at what cost? Are deliveries fast enough?

Magist has allowed Eniac to access a snapshot of their database. The data might have the answer to these concerns. Working as a Data Analyst to explore the Magist’s database and make recommendations about the 3-year contract.

**1.2 Understanding the Data**

**1.2.1 The Schema**

![Screenshot 2023-04-19 at 16 56 03](https://user-images.githubusercontent.com/120720780/233132479-6cd504c1-2264-4d32-8af6-8dc6c8c52bee.png)

**1.3 Technical Skills**  
 - SQL
 - Tableau 

**2. Project Outcome**

**2.1. Findings** 

**2.1.1 Magist: Dataset**

Magist product information:
 - Magist has a diverse products portfolio 90% of products non-tech related
 - All analysis concentrated on categories related ot tech products (audio, computer, computer accessories, electronics, telephony)

 Average price of products being sold:
 - All products 267€
 - Tech products 297€

Are expensive tech products popular?
 - Cheaper products sell the most units 
<img width="669" alt="Screenshot 2023-04-19 at 16 44 14" src="https://user-images.githubusercontent.com/120720780/233129283-15631386-29b6-413e-b1d9-cff3f4b8fee9.png">

**2.2 Recommendations**

After reviewing the dataset from Magist my recommendation is that Eniac should **not** sign the three year contract with Magist.

**2.2.1 Three key reasons for this are as follows:** 
 
 **1. Scope and Scale of Magist**
- 12% of magist’s revenues is in relevant categories representing 14% of all magist’s shipments
- Magist does not cooperate with huge catch-all-marketplaces.
- It does not have a highly tech-specialised portfolio.
- It provides no access to relevant high-end tech-product-platforms.
- Therefore the product and sales-driven analysis of the database does not suggest a quick agreement on the proposed contract. 

**2. Delivery-Issues in Brazil**

Only a fraction of deliveries are on time:
- 87.5 % arrive too early -> inconvenient and not building trust
- Avg. estimated delivery time: 22.9 days
- Avg. actual delivery time: 12.1 days
- 57.3 % of Brazilian online shoppers expect a delivery to arrive in maximum 4-7 days (Statista, 2017)
- Avg. shipping cost per order from Magista: 19.9 R$
- Avg. national shipping cost in Brazil: 19.3 R$ (Statista, 2023)

**3. Lack of Information in Data** 

Two key pieces of information we are missing;
1. Brands, it would be great to get brand information to see if Magist already sell Apple products and what competitors of Apple they sell to compare the data 
2. Product names and descriptions - with the product categories they are very vague and although we have made assumptions on the relevant categories having this data would give us that greater understating
Concern from the data set is the big step back in customer base from August to September -99.8% - We would need to understand from Magist the reasoning behind this?
<img width="379" alt="Screenshot 2023-04-19 at 16 52 20" src="https://user-images.githubusercontent.com/120720780/233131433-f49a7899-3db5-478b-8c15-82ff9529516f.png">

**2.3 Further Recommendations:** 
Magist: Continue Negotiations
- Renegotiate and request more precise data from Magist to improve assessments 
Brazil: Localised Expansion 
- São Paulo: 38% of Magist Sales (Tech Categories, Delivered Status)
<img width="288" alt="Screenshot 2023-04-19 at 16 55 14" src="https://user-images.githubusercontent.com/120720780/233132641-adfba3c4-3fa2-4575-9cae-7d372811b456.png">
Other: Companies
- Amazon has 5-10% market share within electronics & media in Brazil (ecommerceDB, 2021)
- Amazon announces one day deliveries in Brazil to tackle rivals (LABS, 2021)






