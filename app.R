
library(shiny)
library(shinydashboard)

# Carregar base -----------------------------------------------------------
imdb <- basesCursoR::pegar_base("imdb")

# gerar escolhas
# escolhas_ano <- seq(from = 2000, to = 2010, by = 1)

# ui ----------------------------------------------------------------------
ui <- dashboardPage(
    
    # sempre nessa ordem: header -> siderbar -> body
    dashboardHeader(title = "Dúvida"),
    
    dashboardSidebar(
        
        sidebarMenu(
            menuItem(text = "Página 1", tabName = "pag1")
        )
        
        # 2. Como usar esse input aqui e ser reativo no módulo?
        # sliderInput(
        #     inputId = "ano",
        #     label = "Selecione um ano",
        #     min = min(escolhas_ano),
        #     max = max(escolhas_ano),
        #     value = max(escolhas_ano),
        #     sep = ""
        # )
        
    ),
    dashboardBody(
        tabItems(
            tabItem(
                tabName = "pag1",
                conteudo_ui("grafico")
            )
        )
    )
    
)


# server ------------------------------------------------------------------
server <- function(input, output, session) {
    
    conteudo_server("grafico", imdb)
    
}

shinyApp(ui, server)