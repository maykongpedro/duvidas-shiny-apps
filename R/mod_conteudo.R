

# UI ----------------------------------------------------------------------
conteudo_ui <- function(id){
    
    # 1. Por que preciso declarar as escolhas aqui e não somente no app?
    escolhas_ano <- seq(from = 2000, to = 2010, by = 1)
    
    ns <-NS(id)
    
    tagList(
        
        h2("Gráfico teste"),
        fluidRow(
            column(
                width = 3,
                
                # 2. Como uso esse input direto na sidebar?
                # colocando um input
                sliderInput(
                    inputId = ns("ano"),
                    label = "Selecione um ano",
                    min = min(escolhas_ano),
                    max = max(escolhas_ano),
                    value = max(escolhas_ano),
                    sep = ""
                )
            )
        ),
        fluidRow(
            column(
                width = 12,
                plotOutput(outputId = ns("grafico"))
            )
        )
    )
}


# Server ------------------------------------------------------------------
conteudo_server <- function(id, base){
    moduleServer(id, function(input, output, session){
        
        # browser()
        
        # 3. Filtrar a base em um reactive ou dentro do render plot?
        imdb_filtrado <- reactive({
            imdb_filtrado <- base |> 
                dplyr::filter(ano == input$ano)
        })
        
        output$grafico <- renderPlot({
            
            # 3. Filtrar a base em um reactive ou dentro do render plot?
            # imdb_filtrado <- imdb |> 
            #     dplyr::filter(ano == input$ano)
            
            imdb_filtrado() |> 
                dplyr::group_by(nota_imdb) |> 
                dplyr::summarise(receita_tot = sum(receita, na.rm = TRUE)) |> 
                ggplot2::ggplot() +
                ggplot2::geom_point(
                    ggplot2::aes(
                        x = nota_imdb,
                        y = receita_tot
                    )
                )

        })
    })
}