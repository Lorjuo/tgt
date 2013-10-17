jQuery ->
  
  # Attach jquery fileupload behaviour to each form with class="fileupload"
  $('.fileupload').each ->
    $(this).fileupload

      # Create own dropzone for each upload field
      dropZone: $(this)

      # Automatically start upload when files have been selected
      autoUpload: true

      # Use ajax via javascript instead of json return
      dataType: "script"

      # Disable Iframe transport because this is only a hack for IE < version 10 that doesn't support XmlHttpRequests
      # IframeTransport will be automatically used if normal way fails
      forceIframeTransport: false

      # Only allow sequential file uploads to preserver original upload order
      # https://github.com/blueimp/jQuery-File-Upload/issues/2249
      sequentialUploads: true

      add: (e, data) ->
        types = /(\.|\/)(jpg|jpeg|gif|png)$/i
        file = data.files[0]
        if types.test(file.type) || types.test(file.name)
          data.context = $($.parseHTML(tmpl("template-upload", file)))
          $('.fileupload').append(data.context)
          data.submit()
        else
          alert("#{file.name} is not a pdf, doc or docx image file")
      
      progress: (e, data) ->
        if data.context
          progress = parseInt(data.loaded / data.total * 100, 10)
          data.context.find('.bar').css('width', progress + '%')
      
      done: (e, data) ->
        setTimeout (->
          data.context.hide()
        ), 3000

      always: (e, data) ->
        data.context.find('.bar').css('width', 100 + '%')
      
      fail: (e, data) ->
        alert("#{data.files[0].name} failed to upload.")
        console.log("Upload failed:")
        console.log(data)
        # data.errorThrown
        # data.textStatus;
        # data.jqXHR;