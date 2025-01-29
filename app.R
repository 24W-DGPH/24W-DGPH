library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(DT)
library(plotly)
library(reshape2)
library(viridis)

# Load the data
data <- read.csv("ObesityDataSet_raw_and_data_sinthetic.csv")
colnames(data) <- c("gender", "age", "height", "weight", "family_history", 
                    "freq_high_calorie_food", "eating_vegetables", "main_meals_per_day", 
                    "eating_food_between_meals", "smoke", "water", "calories_consumed", 
                    "physical_activity_per_week", "tech_per_day", "alcohol", 
                    "mode_of_transportation", "obesity_level")


# Define UI
ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = span(tagList(icon("heartbeat"), "Obesity Risk Dashboard"))),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("chart-line")),
      menuItem("Correlation Analysis", tabName = "correlation", icon = icon("chart-area"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "overview",
              fluidRow(
                box(title = "Select Filters", width = 4, status = "primary", solidHeader = TRUE,
                    selectInput("variable", "Select a Risk Factor:",
                                choices = colnames(data)[-c(1, 2, 3, 4, 17)]),
                    selectInput("obesity_level", "Select Obesity Level:",
                                choices = unique(data$obesity_level)),
                    sliderInput("age_range", "Select Age Range:",
                                min = min(data$age), max = max(data$age), value = c(min(data$age), max(data$age))),
                    checkboxInput("show_trend", "Show Density Overlay", value = FALSE)
                ),
                box(title = "Density Plot", width = 8, status = "info", solidHeader = TRUE,
                    plotlyOutput("densityPlot"))
              ),
              fluidRow(
                box(title = "Summary Table", width = 12, status = "warning", solidHeader = TRUE,
                    DTOutput("summaryTable"))
              )
      ),
      tabItem(tabName = "correlation",
              fluidRow(
                box(title = "Scatter Plot", width = 12, status = "danger", solidHeader = TRUE,
                    selectInput("x_var", "Select X Variable:", choices = colnames(data)[sapply(data, is.numeric)]),
                    selectInput("y_var", "Select Y Variable:", choices = colnames(data)[sapply(data, is.numeric)]),
                    plotlyOutput("scatterPlot"))
              )
      )
    )
  )
)

# Define Server
server <- function(input, output) {
  
  filtered_data <- reactive({
    data %>% filter(obesity_level == input$obesity_level, 
                    age >= input$age_range[1], age <= input$age_range[2])
  })
  
  output$densityPlot <- renderPlotly({
    p <- ggplot(filtered_data(), aes_string(x = input$variable, fill = "obesity_level")) +
      geom_density(alpha = 0.6) +
      scale_fill_viridis(discrete = TRUE, option = "C") +
      theme_minimal() +
      labs(title = paste("Density Plot of", input$variable, "by Obesity Level"),
           x = input$variable, y = "Density")
    
    if (input$show_trend) {
      p <- p + geom_line(stat = "density", color = "blue")
    }
    
    ggplotly(p)
  })
  
  output$summaryTable <- renderDT({
    filtered_data() %>%
      group_by(!!sym(input$variable)) %>%
      summarise(Count = n()) %>%
      arrange(desc(Count))
  })
  
  output$scatterPlot <- renderPlotly({
    p <- ggplot(data, aes_string(x = input$x_var, y = input$y_var, color = "obesity_level")) +
      geom_point(alpha = 0.6, size = 3) +
      scale_color_viridis(discrete = TRUE, option = "C") +
      theme_minimal() +
      labs(title = paste("Scatter Plot of", input$x_var, "vs", input$y_var),
           x = input$x_var, y = input$y_var)
    
    ggplotly(p)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
