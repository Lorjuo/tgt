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

      # Only allow sequential file uploads to preserve original upload order
      # https://github.com/blueimp/jQuery-File-Upload/issues/2249
      sequentialUploads: false #true
      # Sequential uploads work, when ordering by filename

      # http://stackoverflow.com/questions/19096946/how-to-resize-images-client-side-using-jquery-file-upload
      # http://stackoverflow.com/questions/22753646/using-jquery-fileupload-with-coffeescript-resizing-image-when-using-add-callba
      # http://stackoverflow.com/questions/21675593/cant-get-image-resizing-to-work-with-jquery-file-upload
      # add: (e, data) ->
      #   types = /(\.|\/)(jpg|jpeg|gif|png)$/i
      #   file = data.files[0]
      #   if types.test(file.type) || types.test(file.name)
      #     data.context = $($.parseHTML(tmpl("template-upload", file)))
      #     $('.fileupload').append(data.context)
      #     data.submit()
      #   else
      #     alert("#{file.name} is not a pdf, doc or docx image file")

      # add: (e, data) ->
      #   current_data = $(this)
      #   data.process(->
      #     return current_data.fileupload('process', data);
      #   ).done(->
      #     data.submit(); 
      #   )

      loadImageMaxFileSize: 25000000 # 25MB
      imageMaxWidth: 800
      imageMaxHeight: 800
      disableImageResize: false
      process:[
        {
          action: 'load',
          fileTypes: /^image\/(gif|jpeg|png)$/,
          maxFileSize: 25000000 # 25MB
        },
        {
          action: 'resize',
          maxWidth: 800,
          maxHeight: 800#,
          #minWidth: 480,
          #minHeight: 360
        },
        {
          action: 'save'
        }
      ]

      add: (e, data) ->
        #unique_token = token();
        if (data.files && data.files[0])
          file = data.files[0]
          if(file.size < 25000000)
            if(file.type.substr(0, file.type.indexOf('/')) != 'image')
              alert("Please upload a file with the correct format")
            else
              current_data = $(this)
              data.process(->
                return current_data.fileupload('process', data); #call the process function
              ).done(->
                #data.formData = {token: unique_token};
                # data.context = $('.preview:last');
                # data.context.find('.abort').click(abortUpload);
                # CUSTOM visualization
                data.context = $($.parseHTML(tmpl("template-upload", file)))
                $('.fileupload').append(data.context)
                xhr = data.submit();
                data.context.data('data',{jqXHR: xhr});
                #data.submit()
              )
          else
            alert("one of your files is over 200MB")
      
      progress: (e, data) ->
        if data.context
          progress = parseInt(data.loaded / data.total * 100, 10)
          data.context.find('.progress-bar').css('width', progress + '%')
      
      done: (e, data) ->
        data.context.find('.progress-bar').addClass('progress-bar-success')
        data.context.find('.progress').removeClass('progress-striped active')
        setTimeout (->
          data.context.hide()
        ), 3000

      always: (e, data) ->
        data.context.find('.progress').removeClass('progress-striped active')
        data.context.find('.progress-bar').css('width', 100 + '%')
      
      fail: (e, data) ->
        data.context.find('.progress-bar').addClass('progress-bar-danger')
        alert("#{data.files[0].name} failed to upload.")
        console.log("Upload failed:")
        console.log(data)
        # data.errorThrown
        # data.textStatus;
        # data.jqXHR;