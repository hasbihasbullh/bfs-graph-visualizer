## APPLICATION OF BFS ALGORITHM ##
#.install.packages("shiny")
#.install.packages("visNetwork")


# ============================================================
# ARTIFICIAL INTELLIGENCE PROGRAM: BREADTH-FIRST SEARCH (BFS)
# GUI built with RStudio + Shiny + visNetwork
# ============================================================

library(shiny)
library(visNetwork)

# 1. Create graph definition
nodes <- data.frame(
  id = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J"),
  label = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J"),
  stringsAsFactors = FALSE
)

edges <- data.frame(
  from = c("A", "A", "A", "B", "B", "C", "C", "D", "E", "F", "G", "H", "I"),
  to   = c("B", "C", "H", "D", "E", "F", "G", "I", "I", "J", "J", "I", "J"),
  stringsAsFactors = FALSE
)

# 2. Build adjacency list (Extreme Shuffle - Variation 5)
graph_base <- list(
  B = c("D", "E", "A"),
  G = c("J", "C"),
  I = c("D", "E", "J", "H"),
  F = c("C", "J"),
  A = c("C", "H", "B"),
  J = c("G", "F", "I"),
  E = c("B", "I"),
  H = c("A", "I"),
  D = c("B", "I"),
  C = c("A", "F", "G")
)

# 2a. Function to shuffle neighbor traversal order
#     Invoked each time BFS search is triggered so
#     exploration order can dynamically vary
shuffle_graph <- function(g) {
  lapply(g, function(neighbors) {
    sample(neighbors)
  })
}

# 3. Breadth-First Search (BFS) algorithm implementation
bfs <- function(graph, start, goal) {
  
  # Validation: Ensure start and goal exist in the graph
  if (!(start %in% names(graph)) || !(goal %in% names(graph))) {
    return(list(
      visited = character(0),
      path = character(0),
      found = FALSE,
      cost = Inf,
      total_visited = 0
    ))
  }
  
  # Edge case: Start node is identical to goal node
  if (start == goal) {
    return(list(
      visited = start,
      path = start,
      found = TRUE,
      cost = 0,
      total_visited = 1
    ))
  }
  
  queue <- start
  visited <- character(0)
  discovered <- start
  parent <- setNames(rep(NA_character_, length(graph)),
                     names(graph))
  
  found <- FALSE
  
  while (length(queue) > 0) {
    
    # Dequeue head element
    current <- queue[1]
    queue <- queue[-1]
    
    visited <- c(visited, current)
    
    # Traverse adjacent neighbors
    for (neighbor in graph[[current]]) {
      
      if (!(neighbor %in% discovered)) {
        
        discovered <- c(discovered, neighbor)
        parent[neighbor] <- current
        
        # Early Goal Test: Check goal immediately upon discovery
        if (neighbor == goal) {
          found <- TRUE
          visited <- c(visited, neighbor)
          break
        }
        
        queue <- c(queue, neighbor)
      }
    }
    
    if (found) {
      break
    }
  }
  
  # Reconstruct solution path from goal back to start safely
  path <- character(0)
  
  if (found) {
    current <- goal
    path <- current
    
    while (!is.na(current) && current != start) {
      current <- parent[current]
      if (!is.na(current)) {
        path <- c(current, path)
      }
    }
  }
  
  return(list(
    visited = visited,
    path = path,
    found = found,
    cost = if (found) length(path) - 1 else Inf,
    total_visited = length(visited)
  ))
}

# 4. GUI Layout Definition
ui <- fluidPage(
  
  titlePanel("Artificial Intelligence - Algoritma BFS (Variasi 5)"),
  
  sidebarLayout(
    
    sidebarPanel(
      h4("Pengaturan Pencarian"),
      
      selectInput(
        "start",
        "Pilih Titik Awal:",
        choices = nodes$id,
        selected = "A"
      ),
      
      selectInput(
        "goal",
        "Pilih Titik Tujuan:",
        choices = nodes$id,
        selected = "J"
      ),
      
      actionButton(
        "search",
        "Jalankan BFS",
        class = "btn-primary"
      ),
      
      hr(),
      
      h4("Informasi Algoritma"),
      p("Metode: Breadth-First Search"),
      p("Strategi: Pencarian melebar"),
      p("Struktur data: Queue (FIFO)"),
      p("Graf: Tidak berarah, tanpa bobot")
    ),
    
    mainPanel(
      
      h3("Visualisasi Graf"),
      
      p("Hijau = titik awal"),
      p("Merah = titik tujuan"),
      p("Biru = jalur hasil pencarian"),
      p("Abu-abu = simpul lainnya"),
      
      visNetworkOutput("graf", height = "450px"),
      
      hr(),
      
      h3("Hasil Pencarian"),
      
      verbatimTextOutput("hasil"),
      
      h3("Urutan Penelusuran"),
      
      verbatimTextOutput("urutan")
    )
  )
)

# 5. Interactive GUI Server Logic
server <- function(input, output, session) {
  
  hasil_bfs <- eventReactive(input$search, {
    
    graph_acak <- shuffle_graph(graph_base)
    
    bfs(
      graph = graph_acak,
      start = input$start,
      goal = input$goal
    )
    
  }, ignoreInit = FALSE)
  
  output$graf <- renderVisNetwork({
    
    hasil <- hasil_bfs()
    
    n <- nodes
    e <- edges
    
    # Node coloring according to BFS search outcome
    n$color.background <- "lightgray"
    n$color.border <- "gray"
    
    if (input$start == input$goal) {
      n$color.background[n$id == input$start] <- "orange"
    } else {
      n$color.background[n$id == input$start] <- "green"
      n$color.background[n$id == input$goal] <- "red"
    }
    
    # Nodes participating in solution path
    for (v in hasil$path) {
      if (v != input$start && v != input$goal) {
        n$color.background[n$id == v] <- "deepskyblue"
      }
    }
    
    # Highlight edges included in solution path
    e$color <- "gray"
    e$width <- 2
    
    if (length(hasil$path) > 1) {
      
      for (i in seq_len(length(hasil$path) - 1)) {
        
        a <- hasil$path[i]
        b <- hasil$path[i + 1]
        
        idx <- which(
          (e$from == a & e$to == b) |
            (e$from == b & e$to == a)
        )
        
        e$color[idx] <- "blue"
        e$width[idx] <- 5
      }
    }
    
    visNetwork(n, e) %>%
      visNodes(
        shape = "dot",
        size = 30,
        font = list(size = 22)
      ) %>%
      visEdges(smooth = FALSE) %>%
      visOptions(
        highlightNearest = TRUE,
        nodesIdSelection = FALSE
      ) %>%
      visPhysics(
        enabled = TRUE,
        solver = "barnesHut",
        barnesHut = list(
          gravitationalConstant = -3000,
          centralGravity = 0.3,
          springLength = 150,
          springConstant = 0.04,
          damping = 0.95          # High damping factor (0 to 1) to stop shaking quickly
        ),
        stabilization = list(
          enabled = TRUE,
          iterations = 150        # Stabilize initial positions so nodes do not overlap
        )
      )
    
  })
  
  output$hasil <- renderText({
    
    hasil <- hasil_bfs()
    
    if (hasil$found) {
      
      paste0(
        "Status: Tujuan ditemukan\n",
        "Titik awal: ", input$start, "\n",
        "Titik tujuan: ", input$goal, "\n",
        "Jalur solusi: ",
        paste(hasil$path, collapse = " -> "), "\n",
        "Jumlah sisi jalur: ",
        length(hasil$path) - 1
      )
      
    } else {
      
      "Tujuan tidak ditemukan."
      
    }
  })
  
  output$urutan <- renderText({
    
    hasil <- hasil_bfs()
    
    paste(
      hasil$visited,
      collapse = " -> "
    )
    
  })
}

# 6. Run Shiny Application
shinyApp(ui = ui, server = server)
