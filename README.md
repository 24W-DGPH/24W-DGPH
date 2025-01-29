_**Digital Health Dashboard**_

**Overview**

This repository contains an interactive Shiny application focused on obesity risk factors and its data visualization. The application is designed to analyze and present risk factors that contribute in obesity for research and decision-making purposes.

**Live Application**

You can access the deployed Shiny app here:
 https://hardika273.shinyapps.io/digital_health/

**Repository Contents**

_app.R _- The main Shiny app script.

_ObesityDataSet_raw_and_data_sinthetic.csv_ - Dataset used in the application.

_digital_health.dcf _- Supporting configuration file.

_hardi.html_ - Initial documentation or related HTML content.

**Installation and Usage**

To run the application locally, follow these steps:

_Clone this repository:_

git clone https://github.com/24W-DGPH/24W-DGPH.git

_Open RStudio and install required packages (if not already installed)_:

install.packages(c("shiny", "ggplot2", "dplyr"))

_Run the application:_

shiny::runApp("app.R")
