jQuery(document).ready(function ($) {
    Trix.config.attachments.preview.caption = false;
    document.addEventListener("trix-attachment-add", function (event) {
        var attachment = event.attachment;
        if (attachment.file) {
            return uploadAttachment(attachment);
        }
    });
    // This, we don't have to put inside the tubolinks load because as soon as the page loads we'll set up this listener, which will listen to any trix attachment add events, so you could have trix add itself to other pages and whatever, this only needs to be added one time. We don't need to re add this listener every single page that happens, so we're going to have that, and then we're going to have a function up here called Function.attachment(attachment) and we're going to have this do the processing and submission to the server, and then take the result of that, the url of the image and then tell trix what the actual url is. This is really all we have to fill out, but we have to then figure out how do we get the attachment here. We can get the attachment by saying var attachment = event.attachment and then if the attachment.file exists, then we want to upload the attachment, and that's really it, and then we're going to call that and then it will have this function, which we will set up with some form data, so we need to basically submit that file, and we're going to do that using the form data object, and then take an XHR request and submit that over. Now, normally, what I would recommend is using the rails ujs library so you would want to have the rails.ajax method here and do all that normal stuff, but, in this situation, rails.ajax doesn't provide us right now at least with an easy way of adding listeners for the upload progress, which we want to use in order to tell trix how the progress is going for the file upload, so if you have a big file upload, it will display the image that you're uploading or video or whatever it is, that attachment will be displayed there in a progress bar and we want to, ideally be sending that progress information over to trix. So the rails ajax method isn't really going to do a great job for us here, and so we're going to set up an xhr request manually instead.

    // app/assets/javascripts/trix_uploads.js

    function uploadAttachment(attachment) {
        // Create our form data to submit
        var file = attachment.file;
        var form = new FormData;
        form.append("Content-Type", file.type);
        form.append("photo[image]", file);
        //Now we'll have the form data object set up so that we can create a new xhr request:

        // Create our XHR request
        var xhr = new XMLHttpRequest;
        xhr.open("POST", "/photos.json", true);
        xhr.setRequestHeader("X-CSRF-Token", Rails.csrfToken());
        xhr.send(form);
        // Report file uploads back to Trix
        xhr.upload.onprogress = function (event) {
            var progress = event.loaded / event.total * 100;
            attachment.setUploadProgress(progress);
        }

        // We can finish off our xhr upload now, but we need to define this ahead of tie so that that is handled once we fire off the request. We need to add one more function to handle progress here

        // Tell Trix what url and href to use on successful upload
        xhr.onload = function () {
            if (xhr.status === 201) {
                var data = JSON.parse(xhr.responseText);
                return attachment.setAttributes({
                    url: data.image_url,
                    href: data.image_url
                });
            }
        }
    }
});