Digital Health Dashboard

Overview

This repository contains an interactive Shiny application focused on obesity risk factors and its data visualization. The application is designed to analyze and present risk factors that contribute in obesity for research and decision-making purposes.

Live Application

You can access the deployed Shiny app here:
 https://hardika273.shinyapps.io/digital_health/

Repository Contents

app.R - The main Shiny app script.

ObesityDataSet_raw_and_data_sinthetic.csv - Dataset used in the application.

digital_health.dcf - Supporting configuration file.

hardi.html - Initial documentation or related HTML content.

Installation and Usage

To run the application locally, follow these steps:

Clone this repository:

git clone https://github.com/24W-DGPH/24W-DGPH.git

Open RStudio and install required packages (if not already installed):

install.packages(c("shiny", "ggplot2", "dplyr"))

Run the application:

shiny::runApp("app.R")

Contributing

Contributions are welcome! Feel free to submit issues, feature requests, or pull requests to improve the application.

License

This project is open-source and available under the MIT License.
