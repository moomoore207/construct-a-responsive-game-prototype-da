# tlgz_construct_a_res.R

# Load necessary libraries
library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Game Prototype Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Game Settings", tabName = "game_settings", icon = icon("gear")),
      menuItem("Game Data", tabName = "game_data", icon = icon("chart-bar")),
      menuItem("Leaderboard", tabName = "leaderboard", icon = icon("trophy"))
    )
  ),
  dashboardBody(
    tabItems(
      # Game Settings Tab
      tabItem(tabName = "game_settings",
               box(title = "Game Settings", width = 4, 
                   sliderInput("game_difficulty", "Difficulty:", min = 1, max = 10, value = 5),
                   sliderInput("game_timer", "Timer (seconds):", min = 30, max = 300, value = 60),
                   actionButton("save_settings", "Save Settings")
               )
      ),
      
      # Game Data Tab
      tabItem(tabName = "game_data",
               box(title = "Game Data", width = 6, 
                   plotOutput("game_data_plot")
               )
      ),
      
      # Leaderboard Tab
      tabItem(tabName = "leaderboard",
               box(title = "Leaderboard", width = 6, 
                   dataTableOutput("leaderboard_table")
               )
      )
    )
  )
)

# Define Server
server <- function(input, output) {
  # Game Data Plot
  output$game_data_plot <- renderPlot({
    # Generate sample data
    data <- data.frame(x = 1:10, y = runif(10, 0, 1))
    ggplot(data, aes(x, y)) + 
      geom_point() + 
      theme_minimal()
  })
  
  # Leaderboard Table
  output$leaderboard_table <- renderDataTable({
    # Generate sample data
    data <- data.frame(player = c("John", "Jane", "Bob", "Alice"), score = c(100, 80, 120, 90))
    data
  })
}

# Run the application
shinyApp(ui = ui, server = server)