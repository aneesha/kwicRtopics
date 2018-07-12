#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
kwictopicsWidget <- function(topicmodel, no_topics, documents, width = NULL, height = NULL, elementId = NULL) {
  
  terms <- terms(topicmodel, 6)

  
  topics_words <- list()
  for (topic_no in 1:no_topics){
    words <- terms[,topic_no]
    topic_no_str = paste(topic_no,"",sep="")
    topics_words[[topic_no_str]]=words
    #print(topics)
    #print(toJSON(topics))   
  }
  
  topics_docs <- list()
  for (topic_no in 1:no_topics){
    docs_in_topic <- topicmodel@gamma[,topic_no]
    ordered_docs <- order(docs_in_topic, decreasing = TRUE)
    top_ordered_docs <- ordered_docs[1:6]
    topic_no_str = paste(topic_no,"",sep="")
    topics_docs[[topic_no_str]]=top_ordered_docs
    #print(topics)
    #print(toJSON(topics))   
  }
  
  # forward options using x
  x = list( 
    topics_words = topics_words,
    topics_docs = topics_docs,
    documents = documents
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'kwictopicsWidget',
    x,
    width = width,
    height = height,
    package = 'kwictopics',
    elementId = elementId
  )
}

#' Shiny bindings for kwictopicsWidget
#'
#' Output and render functions for using kwictopicsWidget within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a kwictopicsWidget
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name kwictopicsWidget-shiny
#'
#' @export
kwictopicsWidgetOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'kwictopicsWidget', width, height, package = 'kwictopics')
}

#' @rdname kwictopicsWidget-shiny
#' @export
renderKwictopicsWidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, kwictopicsWidgetOutput, env, quoted = TRUE)
}
