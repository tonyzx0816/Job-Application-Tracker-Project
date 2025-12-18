-- CREATE TABLE -----------------------------------------------
CREATE TABLE Company(
	CompanyID INT PRIMARY KEY,
    Website VARCHAR(255),
    Name VARCHAR(255) NOT NULL,
    Size INT
);

CREATE TABLE Position (
    PositionID INT UNIQUE,
    CompanyID INT,
    Description VARCHAR(500), 
    Location VARCHAR(50),
    Salary DECIMAL(10, 2),
    Title VARCHAR(50),
	PRIMARY KEY(PositionID, CompanyID),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE Applicant (
	ApplicantID INT PRIMARY KEY,
    PhoneNumber VARCHAR(20) NOT NULL,
    Address VARCHAR(255),
    FullName VARCHAR(255) NOT NULL,
    Email VARCHAR(255)
);

CREATE TABLE Application (
	ApplicationID INT UNIQUE,
    PositionID INT,
    ApplicantID INT,
    AppliedDate DATETIME,
    LastUpdated DATETIME,
    Status ENUM('Rejected', 'Pending', 'Accepted') NOT NULL,
	PRIMARY KEY(ApplicationID, PositionID, ApplicantID),
    FOREIGN KEY (PositionID) REFERENCES Position (PositionID)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
    FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);


CREATE TABLE ApplicationDocument (
	Type ENUM('Resume', 'CoverLetter', 'Transcript') NOT NULL,
    ApplicationID INT NOT NULL,
    FileName VARCHAR(50),
    FileFormat VARCHAR(50),
	PRIMARY KEY (Type, ApplicationID),
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE Interview (
	InterviewID INT,
    ApplicationID INT NOT NULL,
    InterviewDate DATETIME,
    Status ENUM('Scheduled', 'Completed', 'Fail', 'Pass', 'Rescheduled') NOT NULL,
    Type ENUM('Phone', 'Onsite', 'Video') NOT NULL,
	PRIMARY KEY(InterviewID, ApplicationID),
	FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

-- INSERT SAMPLE DATA -----------------------------------------------
INSERT INTO Company (CompanyID, Website, Name, Size) VALUES 
(1, 'https://www.techgenix.com', 'TechGenix', 500),
(2, 'https://www.innovatex.com', 'Innovatex Solutions', 350),
(3, 'https://www.greenwise.com', 'Greenwise Industries', 1200),
(4, 'https://www.globalfoods.com', 'Global Foods Corp.', 5000),
(5, 'https://www.codepeak.io', 'CodePeak Technologies', 200),
(6, 'https://www.biohealth.com', 'BioHealth Systems', 800),
(7, 'https://www.fastlane.com', 'FastLane Logistics', 400),
(8, 'https://www.solarwave.com', 'SolarWave Energy', 650),
(9, 'https://www.financepro.com', 'FinancePro Solutions', 450),
(10, 'https://www.natureworks.com', 'NatureWorks', 300),
(11, 'https://www.auroraecommerce.com', 'Aurora E-Commerce', 150),
(12, 'https://www.safedrive.com', 'SafeDrive Technologies', 700),
(13, 'https://www.mediacorp.com', 'MediaCorp Inc.', 2500),
(14, 'https://www.fusiontech.com', 'FusionTech Enterprises', 120),
(15, 'https://www.nextgenpharma.com', 'NextGen Pharmaceuticals', 500),
(16, 'https://www.revolvex.com', 'Revolvex', 850),
(17, 'https://www.universaltextiles.com', 'Universal Textiles', 1000),
(18, 'https://www.cyberguard.com', 'CyberGuard Security', 900),
(19, 'https://www.purewater.com', 'PureWater Systems', 150),
(20, 'https://www.stellarbanking.com', 'Stellar Banking', 3500),
(21, 'https://www.vividtech.com', 'VividTech Innovations', 350),
(22, 'https://www.nexgenenergy.com', 'NexGen Energy Solutions', 600),
(23, 'https://www.alphaplastics.com', 'Alpha Plastics Inc.', 2200),
(24, 'https://www.autoworks.com', 'AutoWorks Ltd.', 400),
(25, 'https://www.logisync.com', 'LogiSync Solutions', 150),
(26, 'https://www.omegahealth.com', 'Omega Health Systems', 1000),
(27, 'https://www.bridgeford.com', 'Bridgeford Technologies', 500),
(28, 'https://www.cleantech.com', 'CleanTech Innovations', 600),
(29, 'https://www.vortexsystems.com', 'Vortex Systems', 850),
(30, 'https://www.techtanium.com', 'Techtanium Labs', 1200),
(31, 'https://www.biozene.com', 'BioZene Industries', 400),
(32, 'https://www.summitfoods.com', 'Summit Foods Co.', 4500),
(33, 'https://www.greenfieldcorp.com', 'GreenField Corporation', 600),
(34, 'https://www.technova.com', 'TechNova Inc.', 300),
(35, 'https://www.visionaire.com', 'Visionaire Group', 850),
(36, 'https://www.bluesky.com', 'BlueSky Enterprises', 1100),
(37, 'https://www.agricorp.com', 'AgriCorp', 1500),
(38, 'https://www.supernova.com', 'SuperNova Innovations', 100),
(39, 'https://www.lunartech.com', 'LunarTech Solutions', 250),
(40, 'https://www.goldencircle.com', 'GoldenCircle Ltd.', 200),
(41, 'https://www.crystalclear.com', 'CrystalClear Tech', 500),
(42, 'https://www.highpeak.com', 'HighPeak Technologies', 700),
(43, 'https://www.cirrusware.com', 'CirrusWare', 650),
(44, 'https://www.horizonplastics.com', 'Horizon Plastics', 1800),
(45, 'https://www.aquagenix.com', 'AquaGenix Solutions', 300),
(46, 'https://www.deltavision.com', 'DeltaVision Technologies', 400),
(47, 'https://www.spectruminfinity.com', 'Spectrum Infinity', 950),
(48, 'https://www.zentecsolutions.com', 'Zentec Solutions', 700),
(49, 'https://www.skylineenterprises.com', 'Skyline Enterprises', 1200),
(50, 'https://www.titanicglobal.com', 'Titanic Global', 2500);

INSERT INTO Position (PositionID, CompanyID, Description, Location, Salary, Title) VALUES 
(1, 1, 'Lead Software Developer responsible for designing and implementing software solutions.', 'Chicago, IL', 120000.00, 'Senior Software Engineer'),
(2, 1, 'Junior Software Developer with experience in JavaScript and React frameworks.', 'Chicago, IL', 75000.00, 'Software Engineer'),
(3, 2, 'Senior Data Analyst for analyzing and interpreting data for business solutions.', 'New York, NY', 95000.00, 'Data Analyst'),
(4, 2, 'Project Manager to oversee software project life cycles, client interactions, and deadlines.', 'San Francisco, CA', 110000.00, 'Project Manager'),
(5, 3, 'Operations Manager to ensure efficient and smooth day-to-day business operations.', 'Austin, TX', 80000.00, 'Operations Manager'),
(6, 3, 'Digital Marketing Specialist to develop and implement online marketing campaigns.', 'Los Angeles, CA', 65000.00, 'Marketing Specialist'),
(7, 4, 'Human Resources Manager to manage recruitment, employee relations, and compliance.', 'Miami, FL', 105000.00, 'HR Manager'),
(8, 4, 'Sales Manager responsible for driving sales targets and managing client accounts.', 'Dallas, TX', 95000.00, 'Sales Manager'),
(9, 5, 'Financial Analyst to analyze financial data and create reports for senior management.', 'Chicago, IL', 85000.00, 'Financial Analyst'),
(10, 5, 'Marketing Director responsible for overall marketing strategies and campaigns.', 'New York, NY', 135000.00, 'Marketing Director'),
(11, 6, 'Business Development Manager for identifying new business opportunities and partnerships.', 'Seattle, WA', 90000.00, 'Business Development Manager'),
(12, 6, 'Customer Support Specialist to provide product assistance and resolve customer queries.', 'Portland, OR', 50000.00, 'Customer Support Specialist'),
(13, 7, 'Mechanical Engineer for designing and testing mechanical systems and products.', 'Denver, CO', 80000.00, 'Mechanical Engineer'),
(14, 7, 'Supply Chain Coordinator responsible for managing inventory, logistics, and orders.', 'Chicago, IL', 60000.00, 'Supply Chain Coordinator'),
(15, 8, 'Software Architect to design high-level software solutions and manage development teams.', 'San Francisco, CA', 150000.00, 'Software Architect'),
(16, 8, 'Front-End Developer skilled in HTML, CSS, and JavaScript to develop user interfaces.', 'Austin, TX', 85000.00, 'Front-End Developer'),
(17, 9, 'Full Stack Developer experienced in building and maintaining web applications.', 'Boston, MA', 115000.00, 'Full Stack Developer'),
(18, 9, 'Quality Assurance Engineer to test and ensure software products meet quality standards.', 'Chicago, IL', 75000.00, 'QA Engineer'),
(19, 10, 'Operations Analyst responsible for analyzing operational performance and identifying improvements.', 'Atlanta, GA', 70000.00, 'Operations Analyst'),
(20, 10, 'Product Manager responsible for guiding the development and launch of new products.', 'Denver, CO', 125000.00, 'Product Manager'),
(21, 11, 'Network Engineer for designing and managing computer networks for the organization.', 'San Diego, CA', 95000.00, 'Network Engineer'),
(22, 11, 'System Administrator to maintain and support IT infrastructure and systems.', 'Seattle, WA', 85000.00, 'System Administrator'),
(23, 12, 'Database Administrator to manage and optimize databases for high performance.', 'New York, NY', 105000.00, 'Database Administrator'),
(24, 12, 'UI/UX Designer responsible for creating visually appealing and user-friendly designs.', 'San Francisco, CA', 95000.00, 'UI/UX Designer'),
(25, 13, 'Content Marketing Manager to create and execute content strategies for brand awareness.', 'Los Angeles, CA', 80000.00, 'Content Marketing Manager'),
(26, 13, 'SEO Specialist to optimize website content and improve search engine rankings.', 'Chicago, IL', 70000.00, 'SEO Specialist'),
(27, 14, 'Cloud Architect to design and manage cloud computing systems and applications.', 'Austin, TX', 130000.00, 'Cloud Architect'),
(28, 14, 'DevOps Engineer responsible for automation and streamlining development operations.', 'Seattle, WA', 105000.00, 'DevOps Engineer'),
(29, 15, 'Data Scientist to analyze large datasets and generate insights for business strategy.', 'San Francisco, CA', 120000.00, 'Data Scientist'),
(30, 15, 'Data Engineer responsible for developing data pipelines and architecture.', 'New York, NY', 100000.00, 'Data Engineer'),
(31, 16, 'Cybersecurity Analyst to protect the organization’s data and IT systems from security breaches.', 'Boston, MA', 95000.00, 'Cybersecurity Analyst'),
(32, 16, 'Security Engineer to implement and maintain secure systems and networks.', 'Chicago, IL', 105000.00, 'Security Engineer'),
(33, 17, 'Legal Counsel to manage legal matters and ensure compliance with company policies.', 'Dallas, TX', 130000.00, 'Legal Counsel'),
(34, 17, 'Risk Manager to identify, assess, and mitigate risks within the organization.', 'Miami, FL', 115000.00, 'Risk Manager'),
(35, 18, 'Quality Control Manager to ensure products meet safety and quality standards.', 'Los Angeles, CA', 95000.00, 'Quality Control Manager'),
(36, 18, 'Product Designer to create new products and improve existing product designs.', 'Chicago, IL', 105000.00, 'Product Designer'),
(37, 19, 'Technical Support Engineer to assist customers with technical problems and troubleshooting.', 'San Francisco, CA', 75000.00, 'Technical Support Engineer'),
(38, 19, 'Customer Success Manager to manage client relationships and ensure satisfaction.', 'Dallas, TX', 85000.00, 'Customer Success Manager'),
(39, 20, 'Digital Product Designer to create and prototype digital products with user-friendly interfaces.', 'Austin, TX', 95000.00, 'Digital Product Designer'),
(40, 20, 'Front-End Developer responsible for building the front-end architecture for web applications.', 'Seattle, WA', 105000.00, 'Front-End Developer'),
(41, 21, 'Social Media Manager to develop and implement social media strategies and campaigns.', 'New York, NY', 65000.00, 'Social Media Manager'),
(42, 21, 'Community Manager responsible for building and nurturing online communities and engagement.', 'Los Angeles, CA', 70000.00, 'Community Manager'),
(43, 22, 'Financial Planning Analyst to assist in budget planning and financial forecasting.', 'San Diego, CA', 85000.00, 'Financial Planning Analyst'),
(44, 22, 'Corporate Accountant responsible for managing financial records and tax compliance.', 'Chicago, IL', 90000.00, 'Corporate Accountant'),
(45, 23, 'Product Marketing Manager to plan and execute product marketing strategies.', 'Boston, MA', 95000.00, 'Product Marketing Manager'),
(46, 23, 'Brand Strategist to manage and grow the company’s brand identity and presence.', 'Miami, FL', 100000.00, 'Brand Strategist'),
(47, 24, 'International Sales Manager to drive sales across multiple countries and regions.', 'London, UK', 110000.00, 'International Sales Manager'),
(48, 24, 'Customer Service Supervisor to lead and oversee a team of customer service representatives.', 'Chicago, IL', 80000.00, 'Customer Service Supervisor'),
(49, 25, 'Research Scientist to conduct experiments and research in biotechnology and pharmaceuticals.', 'San Francisco, CA', 120000.00, 'Research Scientist'),
(50, 25, 'Clinical Research Coordinator to manage and oversee clinical trials for new medical treatments.', 'New York, NY', 95000.00, 'Clinical Research Coordinator'),
(51, 26, 'Network Security Engineer to monitor and protect network infrastructure from cyber threats.', 'San Francisco, CA', 105000.00, 'Network Security Engineer'),
(52, 26, 'Product Designer responsible for user experience research and product development.', 'Los Angeles, CA', 95000.00, 'Product Designer'),
(53, 27, 'Data Engineer for building scalable data pipelines and architecture for business insights.', 'Chicago, IL', 110000.00, 'Data Engineer'),
(54, 27, 'Technical Writer responsible for creating user manuals, guides, and documentation.', 'Austin, TX', 75000.00, 'Technical Writer'),
(55, 28, 'Machine Learning Engineer to design and implement machine learning algorithms for predictive models.', 'Seattle, WA', 120000.00, 'Machine Learning Engineer'),
(56, 28, 'QA Automation Engineer responsible for automating the testing of software applications.', 'New York, NY', 85000.00, 'QA Automation Engineer'),
(57, 29, 'Cloud Engineer to manage cloud infrastructure, deployment, and solutions in AWS and Azure.', 'Miami, FL', 115000.00, 'Cloud Engineer'),
(58, 29, 'Software Tester responsible for manual and automated software testing for product releases.', 'Chicago, IL', 75000.00, 'Software Tester'),
(59, 30, 'Business Analyst to analyze market trends, data, and business performance for strategy recommendations.', 'San Francisco, CA', 90000.00, 'Business Analyst'),
(60, 30, 'Graphic Designer to create digital graphics, advertisements, and content for social media.', 'Los Angeles, CA', 65000.00, 'Graphic Designer'),
(61, 31, 'Digital Transformation Manager to drive digital change and innovation within the company.', 'New York, NY', 125000.00, 'Digital Transformation Manager'),
(62, 31, 'UI/UX Designer to create intuitive user interfaces and experiences for web and mobile applications.', 'Austin, TX', 95000.00, 'UI/UX Designer'),
(63, 32, 'Technical Support Specialist to provide high-level troubleshooting and technical assistance to clients.', 'Denver, CO', 75000.00, 'Technical Support Specialist'),
(64, 32, 'Operations Analyst to analyze business processes, identify issues, and implement solutions.', 'Chicago, IL', 85000.00, 'Operations Analyst'),
(65, 33, 'Software Development Manager responsible for managing development teams and overseeing project progress.', 'San Francisco, CA', 140000.00, 'Software Development Manager'),
(66, 33, 'Business Intelligence Analyst to collect, analyze, and present data to drive business decisions.', 'Los Angeles, CA', 95000.00, 'Business Intelligence Analyst'),
(67, 34, 'Customer Relationship Manager to ensure high-quality client service and engagement.', 'Miami, FL', 95000.00, 'Customer Relationship Manager'),
(68, 34, 'Social Media Strategist responsible for planning and executing social media campaigns.', 'Chicago, IL', 80000.00, 'Social Media Strategist'),
(69, 35, 'Cloud Solutions Architect responsible for designing cloud solutions and optimizing cloud infrastructure.', 'Austin, TX', 130000.00, 'Cloud Solutions Architect'),
(70, 35, 'Sales Development Representative responsible for lead generation and qualifying sales prospects.', 'New York, NY', 60000.00, 'Sales Development Representative'),
(71, 36, 'DevOps Manager to oversee DevOps processes, tools, and pipeline automation.', 'San Francisco, CA', 125000.00, 'DevOps Manager'),
(72, 36, 'Project Coordinator to assist in managing projects, deadlines, and internal communication.', 'Los Angeles, CA', 65000.00, 'Project Coordinator'),
(73, 37, 'Operations Director responsible for overseeing all operations and driving operational excellence.', 'Chicago, IL', 145000.00, 'Operations Director'),
(74, 37, 'Cloud Engineer to deploy and manage cloud infrastructure using AWS and GCP.', 'Miami, FL', 110000.00, 'Cloud Engineer'),
(75, 38, 'Software Engineer to develop and maintain software applications with a focus on scalability.', 'Seattle, WA', 105000.00, 'Software Engineer'),
(76, 38, 'Customer Success Engineer to ensure customers are getting maximum value from products and services.', 'Austin, TX', 80000.00, 'Customer Success Engineer'),
(77, 39, 'Data Visualization Specialist to design and create compelling visual representations of data.', 'New York, NY', 90000.00, 'Data Visualization Specialist'),
(78, 39, 'Backend Developer to work on the server side of applications, building APIs and databases.', 'Chicago, IL', 100000.00, 'Backend Developer'),
(79, 40, 'Product Owner responsible for defining product requirements, priorities, and managing product roadmap.', 'Los Angeles, CA', 120000.00, 'Product Owner'),
(80, 40, 'Marketing Analyst to conduct market research and provide insights to inform business strategies.', 'San Francisco, CA', 70000.00, 'Marketing Analyst'),
(81, 41, 'Web Developer to develop and maintain websites, ensuring functionality and performance.', 'Austin, TX', 95000.00, 'Web Developer'),
(82, 41, 'Talent Acquisition Specialist responsible for sourcing and recruiting top talent for the company.', 'Chicago, IL', 65000.00, 'Talent Acquisition Specialist'),
(83, 42, 'Chief Technology Officer to lead the technology strategy and ensure effective implementation of IT systems.', 'San Francisco, CA', 180000.00, 'Chief Technology Officer'),
(84, 42, 'Finance Manager to manage budgeting, forecasting, and financial reporting for the company.', 'New York, NY', 120000.00, 'Finance Manager'),
(85, 43, 'Mobile Application Developer responsible for building and maintaining mobile apps.', 'Seattle, WA', 115000.00, 'Mobile Application Developer'),
(86, 43, 'Business Development Representative to identify and cultivate new business opportunities.', 'Los Angeles, CA', 75000.00, 'Business Development Representative'),
(87, 44, 'Customer Support Manager to oversee a team of support representatives and improve customer experience.', 'Chicago, IL', 85000.00, 'Customer Support Manager'),
(88, 44, 'Operations Assistant to assist with administrative tasks and operational management.', 'Miami, FL', 50000.00, 'Operations Assistant'),
(89, 45, 'Chief Financial Officer to manage the company’s financial planning, analysis, and reporting.', 'New York, NY', 200000.00, 'Chief Financial Officer'),
(90, 45, 'Marketing Executive to plan and implement marketing campaigns to drive business growth.', 'Austin, TX', 95000.00, 'Marketing Executive'),
(91, 46, 'Chief Operating Officer to oversee day-to-day operations and implement business strategies.', 'Chicago, IL', 180000.00, 'Chief Operating Officer'),
(92, 46, 'Legal Associate responsible for providing legal guidance and managing contracts.', 'San Francisco, CA', 95000.00, 'Legal Associate'),
(93, 47, 'Senior Software Engineer to lead development teams and mentor junior developers.', 'Los Angeles, CA', 130000.00, 'Senior Software Engineer'),
(94, 47, 'HR Specialist to manage employee relations, performance, and recruitment processes.', 'Austin, TX', 70000.00, 'HR Specialist'),
(95, 48, 'Chief Marketing Officer to lead overall marketing strategy and business growth initiatives.', 'New York, NY', 160000.00, 'Chief Marketing Officer'),
(96, 48, 'Compliance Officer to ensure compliance with legal regulations and industry standards.', 'Miami, FL', 105000.00, 'Compliance Officer'),
(97, 49, 'Software Solutions Architect to design high-level technical solutions and lead development teams.', 'Chicago, IL', 145000.00, 'Software Solutions Architect'),
(98, 49, 'Sales Engineer responsible for providing technical support during sales processes.', 'San Francisco, CA', 95000.00, 'Sales Engineer'),
(99, 50, 'Data Science Manager to oversee the data science team and drive business insights from data.', 'Seattle, WA', 140000.00, 'Data Science Manager'),
(100, 50, 'Senior Product Manager to define product strategy, roadmap, and drive cross-functional collaboration.', 'Los Angeles, CA', 130000.00, 'Senior Product Manager');

INSERT INTO Applicant (ApplicantID, PhoneNumber, Address, FullName, Email) VALUES 
(1, '415-555-1010', '1234 Elm St, San Francisco, CA', 'John Doe', 'john.doe@email.com'),
(2, '312-555-2020', '5678 Oak Ave, Chicago, IL', 'Jane Smith', 'jane.smith@email.com'),
(3, '646-555-3030', '9101 Pine Rd, New York, NY', 'Emily Clark', 'emily.clark@email.com'),
(4, '408-555-4040', '1122 Maple Dr, San Jose, CA', 'Michael Johnson', 'michael.johnson@email.com'),
(5, '305-555-5050', '1313 Cedar Ln, Miami, FL', 'Sarah Lee', 'sarah.lee@email.com'),
(6, '213-555-6060', '1414 Birch Blvd, Los Angeles, CA', 'David Kim', 'david.kim@email.com'),
(7, '512-555-7070', '1515 Redwood St, Austin, TX', 'Laura Davis', 'laura.davis@email.com'),
(8, '303-555-8080', '1616 Walnut Ct, Denver, CO', 'James Martinez', 'james.martinez@email.com'),
(9, '415-555-9090', '1717 Chestnut Way, San Francisco, CA', 'Jennifer White', 'jennifer.white@email.com'),
(10, '214-555-0101', '1818 Ash Dr, Dallas, TX', 'Robert Taylor', 'robert.taylor@email.com'),
(11, '323-555-1111', '1920 Fir St, Los Angeles, CA', 'Mary Wilson', 'mary.wilson@email.com'),
(12, '718-555-1212', '2021 Hickory Ln, Brooklyn, NY', 'Thomas Lee', 'thomas.lee@email.com'),
(13, '626-555-1313', '2122 Pinewood Rd, Pasadena, CA', 'Elizabeth Gonzalez', 'elizabeth.gonzalez@email.com'),
(14, '505-555-1414', '2223 Willow Dr, Albuquerque, NM', 'Brian Harris', 'brian.harris@email.com'),
(15, '646-555-1515', '2324 Oakwood Ave, New York, NY', 'Megan Scott', 'megan.scott@email.com'),
(16, '858-555-1616', '2425 Birchwood St, San Diego, CA', 'Kevin Walker', 'kevin.walker@email.com'),
(17, '703-555-1717', '2526 Cedarwood Rd, Arlington, VA', 'Olivia Perez', 'olivia.perez@email.com'),
(18, '972-555-1818', '2627 Redwood Ave, Plano, TX', 'Daniel Young', 'daniel.young@email.com'),
(19, '312-555-1919', '2728 Maplewood Blvd, Chicago, IL', 'Sophia Roberts', 'sophia.roberts@email.com'),
(20, '619-555-2020', '2829 Oakwood Rd, San Diego, CA', 'William Walker', 'william.walker@email.com'),
(21, '213-555-2121', '2930 Chestnut Ave, Los Angeles, CA', 'Abigail Clark', 'abigail.clark@email.com'),
(22, '415-555-2222', '3031 Birch Ave, San Francisco, CA', 'Ethan Rodriguez', 'ethan.rodriguez@email.com'),
(23, '503-555-2323', '3132 Pine St, Portland, OR', 'Sophia Martinez', 'sophia.martinez@email.com'),
(24, '949-555-2424', '3233 Redwood Ln, Irvine, CA', 'Liam Adams', 'liam.adams@email.com'),
(25, '818-555-2525', '3334 Willow Blvd, Burbank, CA', 'Charlotte Moore', 'charlotte.moore@email.com'),
(26, '703-555-2626', '3435 Cedar Dr, Reston, VA', 'Matthew Clark', 'matthew.clark@email.com'),
(27, '408-555-2727', '3536 Oak Ct, San Jose, CA', 'Amelia Scott', 'amelia.scott@email.com'),
(28, '972-555-2828', '3637 Maple Ln, Dallas, TX', 'Isabella Harris', 'isabella.harris@email.com'),
(29, '646-555-2929', '3738 Birchwood St, New York, NY', 'Henry Young', 'henry.young@email.com'),
(30, '415-555-3030', '3839 Redwood Rd, San Francisco, CA', 'Victoria Evans', 'victoria.evans@email.com'),
(31, '305-555-3131', '3940 Willow Dr, Miami, FL', 'Zoe Miller', 'zoe.miller@email.com'),
(32, '213-555-3232', '4041 Oakwood Ave, Los Angeles, CA', 'Jack Wilson', 'jack.wilson@email.com'),
(33, '323-555-3333', '4142 Pine Rd, Los Angeles, CA', 'Lucas Allen', 'lucas.allen@email.com'),
(34, '718-555-3434', '4243 Birch Ln, Brooklyn, NY', 'Grace King', 'grace.king@email.com'),
(35, '619-555-3535', '4344 Maplewood St, San Diego, CA', 'Elijah Walker', 'elijah.walker@email.com'),
(36, '312-555-3636', '4445 Redwood Ave, Chicago, IL', 'Avery Lee', 'avery.lee@email.com'),
(37, '503-555-3737', '4546 Oakwood Rd, Portland, OR', 'Carter Hall', 'carter.hall@email.com'),
(38, '408-555-3838', '4647 Cedarwood Blvd, San Jose, CA', 'Chloe Lopez', 'chloe.lopez@email.com'),
(39, '213-555-3939', '4748 Pinewood Ave, Los Angeles, CA', 'Benjamin Scott', 'benjamin.scott@email.com'),
(40, '415-555-4040', '4849 Willowwood Rd, San Francisco, CA', 'Mia Turner', 'mia.turner@email.com'),
(41, '703-555-4141', '4950 Maple Ave, Arlington, VA', 'Sebastian Martin', 'sebastian.martin@email.com'),
(42, '214-555-4242', '5051 Birchwood Dr, Dallas, TX', 'Lily Allen', 'lily.allen@email.com'),
(43, '323-555-4343', '5152 Oakwood Blvd, Los Angeles, CA', 'Oliver Carter', 'oliver.carter@email.com'),
(44, '408-555-4444', '5253 Redwood Dr, San Jose, CA', 'Hannah Moore', 'hannah.moore@email.com'),
(45, '646-555-4545', '5354 Maplewood Rd, New York, NY', 'Levi Brown', 'levi.brown@email.com'),
(46, '619-555-4646', '5455 Pinewood Blvd, San Diego, CA', 'Ella Wilson', 'ella.wilson@email.com'),
(47, '512-555-4747', '5556 Cedar Ln, Austin, TX', 'James Taylor', 'james.taylor@email.com'),
(48, '212-555-4848', '5657 Oakwood Rd, New York, NY', 'Sophie Gonzalez', 'sophie.gonzalez@email.com'),
(49, '713-555-4949', '5758 Birch Ave, Houston, TX', 'Noah Lewis', 'noah.lewis@email.com'),
(50, '951-555-5050', '5859 Willow St, Riverside, CA', 'Madeline Parker', 'madeline.parker@email.com');

INSERT INTO Application (ApplicationID, PositionID, ApplicantID, AppliedDate, LastUpdated, Status) VALUES
(1, 1, 1, '2025-01-01 10:00:00', '2025-01-01 10:00:00', 'Pending'),
(2, 2, 1, '2025-01-02 11:00:00', '2025-01-02 11:00:00', 'Accepted'),
(3, 3, 1, '2025-01-03 12:00:00', '2025-01-03 12:00:00', 'Rejected'),
(4, 4, 2, '2025-01-04 13:00:00', '2025-01-04 13:00:00', 'Pending'),
(5, 5, 2, '2025-01-05 14:00:00', '2025-01-05 14:00:00', 'Accepted'),
(6, 6, 3, '2025-01-06 15:00:00', '2025-01-06 15:00:00', 'Pending'),
(7, 7, 3, '2025-01-07 16:00:00', '2025-01-07 16:00:00', 'Rejected'),
(8, 8, 4, '2025-01-08 17:00:00', '2025-01-08 17:00:00', 'Pending'),
(9, 9, 4, '2025-01-09 18:00:00', '2025-01-09 18:00:00', 'Accepted'),
(10, 10, 5, '2025-01-10 19:00:00', '2025-01-10 19:00:00', 'Rejected'),
(11, 11, 5, '2025-01-11 10:00:00', '2025-01-11 10:00:00', 'Pending'),
(12, 12, 6, '2025-01-12 11:00:00', '2025-01-12 11:00:00', 'Accepted'),
(13, 13, 6, '2025-01-13 12:00:00', '2025-01-13 12:00:00', 'Rejected'),
(14, 14, 7, '2025-01-14 13:00:00', '2025-01-14 13:00:00', 'Pending'),
(15, 15, 7, '2025-01-15 14:00:00', '2025-01-15 14:00:00', 'Accepted'),
(16, 16, 8, '2025-01-16 15:00:00', '2025-01-16 15:00:00', 'Pending'),
(17, 17, 8, '2025-01-17 16:00:00', '2025-01-17 16:00:00', 'Rejected'),
(18, 18, 9, '2025-01-18 17:00:00', '2025-01-18 17:00:00', 'Pending'),
(19, 19, 9, '2025-01-19 18:00:00', '2025-01-19 18:00:00', 'Accepted'),
(20, 20, 10, '2025-01-20 19:00:00', '2025-01-20 19:00:00', 'Rejected'),
(21, 21, 10, '2025-01-21 10:00:00', '2025-01-21 10:00:00', 'Pending'),
(22, 22, 11, '2025-01-22 11:00:00', '2025-01-22 11:00:00', 'Accepted'),
(23, 23, 11, '2025-01-23 12:00:00', '2025-01-23 12:00:00', 'Rejected'),
(24, 24, 12, '2025-01-24 13:00:00', '2025-01-24 13:00:00', 'Pending'),
(25, 25, 12, '2025-01-25 14:00:00', '2025-01-25 14:00:00', 'Accepted'),
(26, 26, 13, '2025-01-26 15:00:00', '2025-01-26 15:00:00', 'Pending'),
(27, 27, 13, '2025-01-27 16:00:00', '2025-01-27 16:00:00', 'Rejected'),
(28, 28, 14, '2025-01-28 17:00:00', '2025-01-28 17:00:00', 'Pending'),
(29, 29, 14, '2025-01-29 18:00:00', '2025-01-29 18:00:00', 'Accepted'),
(30, 30, 15, '2025-01-30 19:00:00', '2025-01-30 19:00:00', 'Rejected'),
(31, 31, 15, '2025-02-01 10:00:00', '2025-02-01 10:00:00', 'Pending'),
(32, 32, 16, '2025-02-02 11:00:00', '2025-02-02 11:00:00', 'Accepted'),
(33, 33, 16, '2025-02-03 12:00:00', '2025-02-03 12:00:00', 'Rejected'),
(34, 34, 17, '2025-02-04 13:00:00', '2025-02-04 13:00:00', 'Pending'),
(35, 35, 17, '2025-02-05 14:00:00', '2025-02-05 14:00:00', 'Accepted'),
(36, 36, 18, '2025-02-06 15:00:00', '2025-02-06 15:00:00', 'Pending'),
(37, 37, 18, '2025-02-07 16:00:00', '2025-02-07 16:00:00', 'Rejected'),
(38, 38, 19, '2025-02-08 17:00:00', '2025-02-08 17:00:00', 'Pending'),
(39, 39, 19, '2025-02-09 18:00:00', '2025-02-09 18:00:00', 'Accepted'),
(40, 40, 20, '2025-02-10 19:00:00', '2025-02-10 19:00:00', 'Rejected'),
(41, 41, 20, '2025-02-11 10:00:00', '2025-02-11 10:00:00', 'Pending'),
(42, 42, 21, '2025-02-12 11:00:00', '2025-02-12 11:00:00', 'Accepted'),
(43, 43, 21, '2025-02-13 12:00:00', '2025-02-13 12:00:00', 'Rejected'),
(44, 44, 22, '2025-02-14 13:00:00', '2025-02-14 13:00:00', 'Pending'),
(45, 45, 22, '2025-02-15 14:00:00', '2025-02-15 14:00:00', 'Accepted'),
(46, 46, 23, '2025-02-16 15:00:00', '2025-02-16 15:00:00', 'Pending'),
(47, 47, 23, '2025-02-17 16:00:00', '2025-02-17 16:00:00', 'Rejected'),
(48, 48, 24, '2025-02-18 17:00:00', '2025-02-18 17:00:00', 'Pending'),
(49, 49, 24, '2025-02-19 18:00:00', '2025-02-19 18:00:00', 'Accepted'),
(50, 50, 25, '2025-02-20 19:00:00', '2025-02-20 19:00:00', 'Rejected'),
(51, 51, 25, '2025-02-21 10:00:00', '2025-02-21 10:00:00', 'Pending'),
(52, 52, 26, '2025-02-22 11:00:00', '2025-02-22 11:00:00', 'Accepted'),
(53, 53, 26, '2025-02-23 12:00:00', '2025-02-23 12:00:00', 'Rejected'),
(54, 54, 27, '2025-02-24 13:00:00', '2025-02-24 13:00:00', 'Pending'),
(55, 55, 27, '2025-02-25 14:00:00', '2025-02-25 14:00:00', 'Accepted'),
(56, 56, 28, '2025-02-26 15:00:00', '2025-02-26 15:00:00', 'Pending'),
(57, 57, 28, '2025-02-27 16:00:00', '2025-02-27 16:00:00', 'Rejected'),
(58, 58, 29, '2025-02-28 17:00:00', '2025-02-28 17:00:00', 'Pending'),
(59, 59, 29, '2025-03-01 18:00:00', '2025-03-01 18:00:00', 'Accepted'),
(60, 60, 30, '2025-03-02 19:00:00', '2025-03-02 19:00:00', 'Rejected'),
(61, 61, 30, '2025-03-03 10:00:00', '2025-03-03 10:00:00', 'Pending'),
(62, 62, 31, '2025-03-04 11:00:00', '2025-03-04 11:00:00', 'Accepted'),
(63, 63, 31, '2025-03-05 12:00:00', '2025-03-05 12:00:00', 'Rejected'),
(64, 64, 32, '2025-03-06 13:00:00', '2025-03-06 13:00:00', 'Pending'),
(65, 65, 32, '2025-03-07 14:00:00', '2025-03-07 14:00:00', 'Accepted'),
(66, 66, 33, '2025-03-08 15:00:00', '2025-03-08 15:00:00', 'Pending'),
(67, 67, 33, '2025-03-09 16:00:00', '2025-03-09 16:00:00', 'Rejected'),
(68, 68, 34, '2025-03-10 17:00:00', '2025-03-10 17:00:00', 'Pending'),
(69, 69, 34, '2025-03-11 18:00:00', '2025-03-11 18:00:00', 'Accepted'),
(70, 70, 35, '2025-03-12 19:00:00', '2025-03-12 19:00:00', 'Rejected'),
(71, 71, 35, '2025-03-13 10:00:00', '2025-03-13 10:00:00', 'Pending'),
(72, 72, 36, '2025-03-14 11:00:00', '2025-03-14 11:00:00', 'Accepted'),
(73, 73, 36, '2025-03-15 12:00:00', '2025-03-15 12:00:00', 'Rejected'),
(74, 74, 37, '2025-03-16 13:00:00', '2025-03-16 13:00:00', 'Pending'),
(75, 75, 37, '2025-03-17 14:00:00', '2025-03-17 14:00:00', 'Accepted'),
(76, 76, 38, '2025-03-18 15:00:00', '2025-03-18 15:00:00', 'Pending'),
(77, 77, 38, '2025-03-19 16:00:00', '2025-03-19 16:00:00', 'Rejected'),
(78, 78, 39, '2025-03-20 17:00:00', '2025-03-20 17:00:00', 'Pending'),
(79, 79, 39, '2025-03-21 18:00:00', '2025-03-21 18:00:00', 'Accepted'),
(80, 80, 40, '2025-03-22 19:00:00', '2025-03-22 19:00:00', 'Rejected'),
(81, 81, 40, '2025-03-23 10:00:00', '2025-03-23 10:00:00', 'Pending'),
(82, 82, 41, '2025-03-24 11:00:00', '2025-03-24 11:00:00', 'Accepted'),
(83, 83, 41, '2025-03-25 12:00:00', '2025-03-25 12:00:00', 'Rejected'),
(84, 84, 42, '2025-03-26 13:00:00', '2025-03-26 13:00:00', 'Pending'),
(85, 85, 42, '2025-03-27 14:00:00', '2025-03-27 14:00:00', 'Accepted'),
(86, 86, 43, '2025-03-28 15:00:00', '2025-03-28 15:00:00', 'Pending'),
(87, 87, 43, '2025-03-29 16:00:00', '2025-03-29 16:00:00', 'Rejected'),
(88, 88, 44, '2025-03-30 17:00:00', '2025-03-30 17:00:00', 'Pending'),
(89, 89, 45, '2025-03-31 18:00:00', '2025-03-31 18:00:00', 'Accepted'),
(90, 90, 45, '2025-04-01 19:00:00', '2025-04-01 19:00:00', 'Rejected'),
(91, 91, 46, '2025-04-02 10:00:00', '2025-04-02 10:00:00', 'Pending'),
(92, 92, 46, '2025-04-03 11:00:00', '2025-04-03 11:00:00', 'Accepted'),
(93, 93, 47, '2025-04-04 12:00:00', '2025-04-04 12:00:00', 'Rejected'),
(94, 94, 47, '2025-04-05 13:00:00', '2025-04-05 13:00:00', 'Pending'),
(95, 95, 48, '2025-04-06 14:00:00', '2025-04-06 14:00:00', 'Accepted'),
(96, 96, 48, '2025-04-07 15:00:00', '2025-04-07 15:00:00', 'Pending'),
(97, 97, 49, '2025-04-08 16:00:00', '2025-04-08 16:00:00', 'Rejected'),
(98, 98, 49, '2025-04-09 17:00:00', '2025-04-09 17:00:00', 'Pending'),
(99, 99, 50, '2025-04-10 18:00:00', '2025-04-10 18:00:00', 'Accepted'),
(100, 100, 50, '2025-04-11 19:00:00', '2025-04-11 19:00:00', 'Rejected');

INSERT INTO ApplicationDocument (Type, ApplicationID, FileName, FileFormat) VALUES 
('Resume', 1, 'JohnDoe_Resume.pdf', 'PDF'),
('CoverLetter', 1, 'JohnDoe_CoverLetter.pdf', 'PDF'),
('Transcript', 1, 'JohnDoe_Transcript.pdf', 'PDF'),
('Resume', 2, 'JaneSmith_Resume.docx', 'DOCX'),
('CoverLetter', 2, 'JaneSmith_CoverLetter.docx', 'DOCX'),
('Transcript', 2, 'JaneSmith_Transcript.pdf', 'PDF'),
('Resume', 3, 'EmilyClark_Resume.pdf', 'PDF'),
('CoverLetter', 3, 'EmilyClark_CoverLetter.pdf', 'PDF'),
('Transcript', 3, 'EmilyClark_Transcript.docx', 'DOCX'),
('Resume', 4, 'MichaelJohnson_Resume.pdf', 'PDF'),
('CoverLetter', 4, 'MichaelJohnson_CoverLetter.pdf', 'PDF'),
('Transcript', 4, 'MichaelJohnson_Transcript.pdf', 'PDF'),
('Resume', 5, 'SarahLee_Resume.docx', 'DOCX'),
('CoverLetter', 5, 'SarahLee_CoverLetter.docx', 'DOCX'),
('Transcript', 5, 'SarahLee_Transcript.pdf', 'PDF'),
('Resume', 6, 'DavidKim_Resume.pdf', 'PDF'),
('CoverLetter', 6, 'DavidKim_CoverLetter.pdf', 'PDF'),
('Transcript', 6, 'DavidKim_Transcript.docx', 'DOCX'),
('Resume', 7, 'LauraDavis_Resume.docx', 'DOCX'),
('CoverLetter', 7, 'LauraDavis_CoverLetter.docx', 'DOCX'),
('Transcript', 7, 'LauraDavis_Transcript.pdf', 'PDF'),
('Resume', 8, 'JamesMartinez_Resume.pdf', 'PDF'),
('CoverLetter', 8, 'JamesMartinez_CoverLetter.pdf', 'PDF'),
('Transcript', 8, 'JamesMartinez_Transcript.pdf', 'PDF'),
('Resume', 9, 'JenniferWhite_Resume.docx', 'DOCX'),
('CoverLetter', 9, 'JenniferWhite_CoverLetter.docx', 'DOCX'),
('Transcript', 9, 'JenniferWhite_Transcript.pdf', 'PDF'),
('Resume', 10, 'RobertTaylor_Resume.pdf', 'PDF'),
('CoverLetter', 10, 'RobertTaylor_CoverLetter.pdf', 'PDF'),
('Transcript', 10, 'RobertTaylor_Transcript.docx', 'DOCX'),
('Resume', 11, 'MaryWilson_Resume.pdf', 'PDF'),
('CoverLetter', 11, 'MaryWilson_CoverLetter.pdf', 'PDF'),
('Transcript', 11, 'MaryWilson_Transcript.pdf', 'PDF'),
('Resume', 12, 'ThomasLee_Resume.docx', 'DOCX'),
('CoverLetter', 12, 'ThomasLee_CoverLetter.docx', 'DOCX'),
('Transcript', 12, 'ThomasLee_Transcript.pdf', 'PDF'),
('Resume', 13, 'ElizabethGonzalez_Resume.pdf', 'PDF'),
('CoverLetter', 13, 'ElizabethGonzalez_CoverLetter.pdf', 'PDF'),
('Transcript', 13, 'ElizabethGonzalez_Transcript.docx', 'DOCX'),
('Resume', 14, 'BrianHarris_Resume.pdf', 'PDF'),
('CoverLetter', 14, 'BrianHarris_CoverLetter.pdf', 'PDF'),
('Transcript', 14, 'BrianHarris_Transcript.pdf', 'PDF'),
('Resume', 15, 'MeganScott_Resume.docx', 'DOCX'),
('CoverLetter', 15, 'MeganScott_CoverLetter.docx', 'DOCX'),
('Transcript', 15, 'MeganScott_Transcript.pdf', 'PDF'),
('Resume', 16, 'KevinWalker_Resume.pdf', 'PDF'),
('CoverLetter', 16, 'KevinWalker_CoverLetter.pdf', 'PDF'),
('Transcript', 16, 'KevinWalker_Transcript.docx', 'DOCX'),
('Resume', 17, 'OliviaPerez_Resume.docx', 'DOCX'),
('CoverLetter', 17, 'OliviaPerez_CoverLetter.docx', 'DOCX'),
('Transcript', 17, 'OliviaPerez_Transcript.pdf', 'PDF'),
('Resume', 18, 'DanielYoung_Resume.pdf', 'PDF'),
('CoverLetter', 18, 'DanielYoung_CoverLetter.pdf', 'PDF'),
('Transcript', 18, 'DanielYoung_Transcript.pdf', 'PDF'),
('Resume', 19, 'SophiaRoberts_Resume.docx', 'DOCX'),
('CoverLetter', 19, 'SophiaRoberts_CoverLetter.docx', 'DOCX'),
('Transcript', 19, 'SophiaRoberts_Transcript.pdf', 'PDF'),
('Resume', 20, 'MatthewAllen_Resume.pdf', 'PDF'),
('CoverLetter', 20, 'MatthewAllen_CoverLetter.pdf', 'PDF'),
('Transcript', 20, 'MatthewAllen_Transcript.pdf', 'PDF'),
('Resume', 21, 'CharlotteMartin_Resume.docx', 'DOCX'),
('CoverLetter', 21, 'CharlotteMartin_CoverLetter.docx', 'DOCX'),
('Transcript', 21, 'CharlotteMartin_Transcript.docx', 'DOCX'),
('Resume', 22, 'BenjaminTaylor_Resume.pdf', 'PDF'),
('CoverLetter', 22, 'BenjaminTaylor_CoverLetter.pdf', 'PDF'),
('Transcript', 22, 'BenjaminTaylor_Transcript.pdf', 'PDF'),
('Resume', 23, 'GraceHernandez_Resume.docx', 'DOCX'),
('CoverLetter', 23, 'GraceHernandez_CoverLetter.docx', 'DOCX'),
('Transcript', 23, 'GraceHernandez_Transcript.pdf', 'PDF'),
('Resume', 24, 'ChristopherMiller_Resume.pdf', 'PDF'),
('CoverLetter', 24, 'ChristopherMiller_CoverLetter.pdf', 'PDF'),
('Transcript', 24, 'ChristopherMiller_Transcript.docx', 'DOCX'),
('Resume', 25, 'LilyClark_Resume.pdf', 'PDF'),
('CoverLetter', 25, 'LilyClark_CoverLetter.pdf', 'PDF'),
('Transcript', 25, 'LilyClark_Transcript.pdf', 'PDF'),
('Resume', 26, 'OliverDavis_Resume.docx', 'DOCX'),
('CoverLetter', 26, 'OliverDavis_CoverLetter.docx', 'DOCX'),
('Transcript', 26, 'OliverDavis_Transcript.pdf', 'PDF'),
('Resume', 27, 'AmeliaRodriguez_Resume.pdf', 'PDF'),
('CoverLetter', 27, 'AmeliaRodriguez_CoverLetter.pdf', 'PDF'),
('Transcript', 27, 'AmeliaRodriguez_Transcript.docx', 'DOCX'),
('Resume', 28, 'HenryJackson_Resume.pdf', 'PDF'),
('CoverLetter', 28, 'HenryJackson_CoverLetter.pdf', 'PDF'),
('Transcript', 28, 'HenryJackson_Transcript.pdf', 'PDF'),
('Resume', 29, 'EllaGonzalez_Resume.docx', 'DOCX'),
('CoverLetter', 29, 'EllaGonzalez_CoverLetter.docx', 'DOCX'),
('Transcript', 29, 'EllaGonzalez_Transcript.pdf', 'PDF'),
('Resume', 30, 'JackMiller_Resume.pdf', 'PDF'),
('CoverLetter', 30, 'JackMiller_CoverLetter.pdf', 'PDF'),
('Transcript', 30, 'JackMiller_Transcript.docx', 'DOCX'),
('Resume', 31, 'MasonMartinez_Resume.docx', 'DOCX'),
('CoverLetter', 31, 'MasonMartinez_CoverLetter.docx', 'DOCX'),
('Transcript', 31, 'MasonMartinez_Transcript.pdf', 'PDF'),
('Resume', 32, 'NatalieLopez_Resume.pdf', 'PDF'),
('CoverLetter', 32, 'NatalieLopez_CoverLetter.pdf', 'PDF'),
('Transcript', 32, 'NatalieLopez_Transcript.pdf', 'PDF'),
('Resume', 33, 'LucasHernandez_Resume.docx', 'DOCX'),
('CoverLetter', 33, 'LucasHernandez_CoverLetter.docx', 'DOCX'),
('Transcript', 33, 'LucasHernandez_Transcript.pdf', 'PDF'),
('Resume', 34, 'ZoeWhite_Resume.pdf', 'PDF'),
('CoverLetter', 34, 'ZoeWhite_CoverLetter.pdf', 'PDF'),
('Transcript', 34, 'ZoeWhite_Transcript.pdf', 'PDF'),
('Resume', 35, 'CalebLewis_Resume.docx', 'DOCX'),
('CoverLetter', 35, 'CalebLewis_CoverLetter.docx', 'DOCX'),
('Transcript', 35, 'CalebLewis_Transcript.pdf', 'PDF'),
('Resume', 36, 'AmosScott_Resume.pdf', 'PDF'),
('CoverLetter', 36, 'AmosScott_CoverLetter.pdf', 'PDF'),
('Transcript', 36, 'AmosScott_Transcript.docx', 'DOCX'),
('Resume', 37, 'DanielHarris_Resume.docx', 'DOCX'),
('CoverLetter', 37, 'DanielHarris_CoverLetter.docx', 'DOCX'),
('Transcript', 37, 'DanielHarris_Transcript.pdf', 'PDF'),
('Resume', 38, 'RubyAdams_Resume.pdf', 'PDF'),
('CoverLetter', 38, 'RubyAdams_CoverLetter.pdf', 'PDF'),
('Transcript', 38, 'RubyAdams_Transcript.pdf', 'PDF'),
('Resume', 39, 'OwenWright_Resume.docx', 'DOCX'),
('CoverLetter', 39, 'OwenWright_CoverLetter.docx', 'DOCX'),
('Transcript', 39, 'OwenWright_Transcript.pdf', 'PDF'),
('Resume', 40, 'JasperTaylor_Resume.pdf', 'PDF'),
('CoverLetter', 40, 'JasperTaylor_CoverLetter.pdf', 'PDF'),
('Transcript', 40, 'JasperTaylor_Transcript.docx', 'DOCX'),
('Resume', 41, 'SamanthaGreen_Resume.docx', 'DOCX'),
('CoverLetter', 41, 'SamanthaGreen_CoverLetter.docx', 'DOCX'),
('Transcript', 41, 'SamanthaGreen_Transcript.pdf', 'PDF'),
('Resume', 42, 'TylerKing_Resume.pdf', 'PDF'),
('CoverLetter', 42, 'TylerKing_CoverLetter.pdf', 'PDF'),
('Transcript', 42, 'TylerKing_Transcript.docx', 'DOCX'),
('Resume', 43, 'SophieYoung_Resume.docx', 'DOCX'),
('CoverLetter', 43, 'SophieYoung_CoverLetter.docx', 'DOCX'),
('Transcript', 43, 'SophieYoung_Transcript.pdf', 'PDF'),
('Resume', 44, 'BenjaminWalker_Resume.pdf', 'PDF'),
('CoverLetter', 44, 'BenjaminWalker_CoverLetter.pdf', 'PDF'),
('Transcript', 44, 'BenjaminWalker_Transcript.pdf', 'PDF'),
('Resume', 45, 'EleanorRoberts_Resume.docx', 'DOCX'),
('CoverLetter', 45, 'EleanorRoberts_CoverLetter.docx', 'DOCX'),
('Transcript', 45, 'EleanorRoberts_Transcript.pdf', 'PDF'),
('Resume', 46, 'TheoKing_Resume.pdf', 'PDF'),
('CoverLetter', 46, 'TheoKing_CoverLetter.pdf', 'PDF'),
('Transcript', 46, 'TheoKing_Transcript.docx', 'DOCX'),
('Resume', 47, 'OliviaEvans_Resume.docx', 'DOCX'),
('CoverLetter', 47, 'OliviaEvans_CoverLetter.docx', 'DOCX'),
('Transcript', 47, 'OliviaEvans_Transcript.pdf', 'PDF'),
('Resume', 48, 'IanHill_Resume.pdf', 'PDF'),
('CoverLetter', 48, 'IanHill_CoverLetter.pdf', 'PDF'),
('Transcript', 48, 'IanHill_Transcript.pdf', 'PDF'),
('Resume', 49, 'LiamMartinez_Resume.docx', 'DOCX'),
('CoverLetter', 49, 'LiamMartinez_CoverLetter.docx', 'DOCX'),
('Transcript', 49, 'LiamMartinez_Transcript.pdf', 'PDF'),
('Resume', 50, 'CharlottePerez_Resume.pdf', 'PDF'),
('CoverLetter', 50, 'CharlottePerez_CoverLetter.pdf', 'PDF'),
('Transcript', 50, 'CharlottePerez_Transcript.docx', 'DOCX');

INSERT INTO Interview (InterviewID, ApplicationID, InterviewDate, Status, Type) VALUES
(1, 1, '2025-10-01 10:00:00', 'Scheduled', 'Phone'),
(2, 2, '2025-10-02 14:30:00', 'Completed', 'Onsite'),
(3, 3, '2025-10-03 09:15:00', 'Pass', 'Phone'),
(4, 4, '2025-10-04 11:00:00', 'Rescheduled', 'Video'),
(5, 5, '2025-10-05 13:45:00', 'Fail', 'Onsite'),
(6, 6, '2025-10-06 10:30:00', 'Scheduled', 'Phone'),
(7, 7, '2025-10-07 16:00:00', 'Completed', 'Onsite'),
(8, 8, '2025-10-08 15:00:00', 'Scheduled', 'Video'),
(9, 9, '2025-10-09 12:00:00', 'Pass', 'Phone'),
(10, 10, '2025-10-10 09:30:00', 'Fail', 'Onsite'),
(11, 11, '2025-10-11 14:00:00', 'Rescheduled', 'Video'),
(12, 12, '2025-10-12 17:00:00', 'Completed', 'Onsite'),
(13, 13, '2025-10-13 10:15:00', 'Pass', 'Phone'),
(14, 14, '2025-10-14 13:30:00', 'Scheduled', 'Phone'),
(15, 15, '2025-10-15 11:00:00', 'Fail', 'Video'),
(16, 16, '2025-10-16 14:45:00', 'Completed', 'Onsite'),
(17, 17, '2025-10-17 12:00:00', 'Rescheduled', 'Phone'),
(18, 18, '2025-10-18 09:45:00', 'Scheduled', 'Video'),
(19, 19, '2025-10-19 10:30:00', 'Pass', 'Onsite'),
(20, 20, '2025-10-20 13:00:00', 'Fail', 'Phone'),
(21, 21, '2025-10-21 14:15:00', 'Scheduled', 'Video'),
(22, 22, '2025-10-22 16:30:00', 'Completed', 'Phone'),
(23, 23, '2025-10-23 11:15:00', 'Pass', 'Onsite'),
(24, 24, '2025-10-24 15:45:00', 'Fail', 'Video'),
(25, 25, '2025-10-25 10:00:00', 'Rescheduled', 'Onsite'),
(26, 26, '2025-10-26 13:30:00', 'Scheduled', 'Phone'),
(27, 27, '2025-10-27 12:15:00', 'Pass', 'Onsite'),
(28, 28, '2025-10-28 14:45:00', 'Completed', 'Phone'),
(29, 29, '2025-10-29 15:00:00', 'Scheduled', 'Video'),
(30, 30, '2025-10-30 16:00:00', 'Pass', 'Phone'),
(31, 31, '2025-10-31 09:30:00', 'Fail', 'Onsite'),
(32, 32, '2025-11-01 11:00:00', 'Scheduled', 'Phone'),
(33, 33, '2025-11-02 12:00:00', 'Completed', 'Video'),
(34, 34, '2025-11-03 10:15:00', 'Rescheduled', 'Phone'),
(35, 35, '2025-11-04 14:00:00', 'Scheduled', 'Onsite'),
(36, 36, '2025-11-05 15:30:00', 'Completed', 'Phone'),
(37, 37, '2025-11-06 09:45:00', 'Fail', 'Video'),
(38, 38, '2025-11-07 11:30:00', 'Pass', 'Phone'),
(39, 39, '2025-11-08 14:00:00', 'Rescheduled', 'Onsite'),
(40, 40, '2025-11-09 13:15:00', 'Scheduled', 'Phone'),
(41, 41, '2025-11-10 09:00:00', 'Completed', 'Onsite'),
(42, 42, '2025-11-11 10:30:00', 'Pass', 'Phone'),
(43, 43, '2025-11-12 15:30:00', 'Scheduled', 'Video'),
(44, 44, '2025-11-13 12:00:00', 'Fail', 'Onsite'),
(45, 45, '2025-11-14 13:45:00', 'Rescheduled', 'Video'),
(46, 46, '2025-11-15 14:30:00', 'Completed', 'Phone'),
(47, 47, '2025-11-16 16:00:00', 'Scheduled', 'Onsite'),
(48, 48, '2025-11-17 11:15:00', 'Pass', 'Phone'),
(49, 49, '2025-11-18 10:00:00', 'Completed', 'Onsite'),
(50, 50, '2025-11-19 13:30:00', 'Scheduled', 'Video');


-- JOIN QUERY -----------------------------------------------
-- 1. INNER JOIN: Get all applications with applicant and position details
SELECT 
    ap.FullName,
    ap.Email,
    p.Title,
    c.Name AS CompanyName,
    a.Status,
    a.AppliedDate
FROM Application a
INNER JOIN Applicant ap ON a.ApplicantID = ap.ApplicantID
INNER JOIN Position p ON a.PositionID = p.PositionID
INNER JOIN Company c ON p.CompanyID = c.CompanyID;

-- 2. LEFT JOIN: Show all applicants and their applications (including those who haven't applied)
SELECT 
    ap.FullName,
    ap.Email,
    COUNT(a.ApplicationID) AS TotalApplications
FROM Applicant ap
LEFT JOIN Application a ON ap.ApplicantID = a.ApplicantID
GROUP BY ap.ApplicantID, ap.FullName, ap.Email;

-- 3. Multiple JOINS: Get interview details with full context
SELECT 
    ap.FullName AS Applicant,
    c.Name AS Company,
    p.Title AS Position,
    i.InterviewDate,
    i.Type AS InterviewType,
    i.Status AS InterviewStatus
FROM Interview i
INNER JOIN Application a ON i.ApplicationID = a.ApplicationID
INNER JOIN Applicant ap ON a.ApplicantID = ap.ApplicantID
INNER JOIN Position p ON a.PositionID = p.PositionID
INNER JOIN Company c ON p.CompanyID = c.CompanyID
ORDER BY i.InterviewDate DESC;


-- UPDATE QUERY -----------------------------------------------
-- 1. Simple UPDATE: Change application status
UPDATE Application
SET Status = 'Accepted', LastUpdated = NOW()
WHERE ApplicationID = 2;

-- 2. UPDATE with JOIN: Update all pending applications for a specific company
UPDATE Application a
INNER JOIN Position p ON a.PositionID = p.PositionID
SET a.Status = 'Rejected', a.LastUpdated = NOW()
WHERE p.CompanyID = 2 AND a.Status = 'Pending';

-- 3. UPDATE based on subquery: Give 10% raise to positions with high demand
UPDATE Position p
SET p.Salary = p.Salary * 1.10
WHERE p.PositionID IN (
    SELECT a.PositionID
    FROM Application a
    GROUP BY a.PositionID
    HAVING COUNT(*) >= 2
)
AND p.PositionID >= 0;

-- 4. UPDATE interview status after completion
UPDATE Interview
SET Status = 'Completed'
WHERE InterviewDate < NOW() 
AND Status = 'Scheduled'
AND InterviewID >= 0;

-- SUBQUERY -----------------------------------------------
-- 1. Subquery in WHERE: Find applicants who applied to Tech Corp positions
SELECT FullName, Email
FROM Applicant
WHERE ApplicantID IN (
    SELECT DISTINCT ApplicantID
    FROM Application a
    INNER JOIN Position p ON a.PositionID = p.PositionID
    WHERE p.CompanyID = (SELECT CompanyID FROM Company WHERE Name = 'Tech Corp')
);

-- 2. Subquery in SELECT: Get companies with number of positions and applications
SELECT 
    c.Name,
    c.Size,
    (SELECT COUNT(*) FROM Position p WHERE p.CompanyID = c.CompanyID) AS TotalPositions,
    (SELECT COUNT(*) 
     FROM Application a 
     INNER JOIN Position p ON a.PositionID = p.PositionID 
     WHERE p.CompanyID = c.CompanyID) AS TotalApplications
FROM Company c;

-- 3. Correlated subquery: Find positions with above-average salaries
SELECT Title, Location, Salary
FROM Position p1
WHERE Salary > (SELECT AVG(Salary) FROM Position);

-- 4. Subquery with EXISTS: Find applicants who have passed at least one interview
SELECT FullName, Email
FROM Applicant ap
WHERE EXISTS (
    SELECT 1
    FROM Application a
    INNER JOIN Interview i ON a.ApplicationID = i.ApplicationID
    WHERE a.ApplicantID = ap.ApplicantID AND i.Status = 'Pass'
);


-- TRIGGER -----------------------------------------------
-- Accept all applications that already passed an interview
CREATE TABLE IF NOT EXISTS ApplicationLog (
  LogID INT AUTO_INCREMENT PRIMARY KEY,
  ApplicationID INT NOT NULL,
  PositionID INT NOT NULL,
  ApplicantID INT NOT NULL,
  OldStatus VARCHAR(20),
  NewStatus VARCHAR(20),
  ChangedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //

CREATE TRIGGER trg_log_when_accepted
AFTER UPDATE ON Application
FOR EACH ROW
BEGIN
  -- Fire only when Status actually changes to 'Accepted'
  IF NEW.Status = 'Accepted' AND NOT (OLD.Status <=> NEW.Status) THEN
    INSERT INTO ApplicationLog (
      ApplicationID, PositionID, ApplicantID, OldStatus, NewStatus, ChangedAt
    )
    VALUES (
      NEW.ApplicationID, NEW.PositionID, NEW.ApplicantID,
      OLD.Status, NEW.Status, NOW()
    );
  END IF;
END//
DELIMITER ;

-- Preview
SELECT COUNT(*) AS to_accept
FROM Application a
WHERE a.Status <> 'Accepted'
  AND EXISTS (
    SELECT 1
    FROM Interview i
    WHERE i.ApplicationID = a.ApplicationID
      AND i.Status = 'Pass'
  );

-- Update
UPDATE Application a
JOIN (
  SELECT DISTINCT ApplicationID
  FROM Interview
  WHERE Status = 'Pass'
) s ON s.ApplicationID = a.ApplicationID
SET a.Status = 'Accepted',
    a.LastUpdated = NOW()
WHERE a.Status <> 'Accepted'
  AND a.ApplicationID >= 0;
  
SELECT *
FROM ApplicationLog
ORDER BY LogID DESC;


-- INDEX -----------------------------------------------
-- Create an index on the Email column to speed up lookups by applicant email
CREATE INDEX idx_applicant_email ON Applicant (Email);

-- Create an index on the FullName column to optimize searches by applicant name
CREATE INDEX idx_applicant_name ON Applicant (FullName);


-- VIEW -----------------------------------------------
CREATE VIEW accepted_interview_applicants AS
SELECT app.ApplicantID, app.FullName, app.Email, doc.ApplicationID
FROM applicant app
JOIN application doc
	ON doc.ApplicantID = app.ApplicantID
WHERE doc.Status = 'Accepted';

SELECT * FROM accepted_interview_applicants;


-- PROCEDURE -----------------------------------------------
DELIMITER $$
CREATE PROCEDURE get_status (
	IN appID INT, 
    IN docID INT, 
    OUT message VARCHAR(50)
)
BEGIN
	DECLARE result ENUM('Rejected', 'Pending', 'Accepted');
    
    SELECT Status INTO result
    FROM application
    WHERE ApplicantID = appID AND ApplicationID = docID;
    
    IF result IS NULL THEN
		SET message = 'enter a valid applicantID and applicationID';
	ELSE
		SET message = result;
	END IF;
    
END $$
DELIMITER ;

SET @status := '';
CALL get_status(66, 5, @status);
SELECT @status;