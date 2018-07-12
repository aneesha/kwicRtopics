HTMLWidgets.widget({

  name: 'kwictopicsWidget',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        //el.innerText = "HELLO";//x.message;
        //$(el).empty();

        topics_words = x.topics_words;
        topics_docs = x.topics_docs;
        documents = x.documents;
        //console.log(topics_words);
        //console.log(topics_docs);
        //console.log(documents);
        topic_html = "";
        
        topic_html += '<nav class="navbar navbar-default"><div class="container-fluid"><div class="navbar-header"><a class="navbar-brand" href="#">KwicTopics Browser</a></div></div></nav>';
        
        for (topic_key in topics_words)
        {
          topic_html += '<div class="panel panel-default">';
          topic_html += '<div class="panel-heading">Topic ' + topic_key + '</div>';
          topic_html += '<div class="panel-body">';
          topic_html += '<div class="input-group">';
          topic_html += '<span class="input-group-addon">Topic Label</span>';
          topic_html += '<input id="msg" type="text" class="form-control" name="msg" placeholder="Enter label">'
          topic_html += '</div>';
          topic_html += '<br />';
          var topic_words_array = topics_words[topic_key];
          for (wrd in topic_words_array){
            var highlight_fn = 'javascript:$(\'#tm_'+topic_key+'\').unmark();$(\'#tm_'+topic_key+'\').mark(\'' + topic_words_array[wrd] + '\',{\'accuracy\': \'partially\'});'
            topic_html += '<a href="' + highlight_fn + '" class="btn btn-info btn-sm" role="button">' + topic_words_array[wrd] + '</a> ';
          }
          
          topic_html += '<br /><br />';
          topic_html += '<div id="tm_' + topic_key + '">';
          topic_html += '<ul class="list-group">';
          var topic_docs_array = topics_docs[topic_key];
          for (doc in topic_docs_array){
            topic_html += '<li class="list-group-item"><input type="checkbox" value="" />  ' + documents[topic_docs_array[doc]] + '</li>';
          }
          topic_html += '</ul>';
          topic_html += '</div>';
          topic_html += '</div>';
          topic_html += '</div>';         
          
        }

        $(el).append(topic_html);
        
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});