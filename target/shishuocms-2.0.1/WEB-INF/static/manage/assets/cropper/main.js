$(function () {

    'use strict';

    var console = window.console || { log: function () {} };
    var URL = window.URL || window.webkitURL;
    var $image = $('#image');
    var $download = $('#download');
    var $dataX = $('#dataX');
    var $dataY = $('#dataY');
    var $dataHeight = $('#dataHeight');
    var $dataWidth = $('#dataWidth');
    var $dataRotate = $('#dataRotate');
    var $dataScaleX = $('#dataScaleX');
    var options = {
        aspectRatio: NaN,
        preview: '.img-preview',
        crop: function (e) {
            $dataX.val(Math.round(e.x));
            $dataY.val(Math.round(e.y));
            $dataHeight.val(Math.round(e.height));
            $dataWidth.val(Math.round(e.width));
            $dataRotate.val(e.rotate);
            $dataScaleX.val(e.scaleX+":"+e.scaleY);

            $("input[name=x]").val(e.x);
            $("input[name=y]").val(e.y);
            $("input[name=height]").val(e.height);
            $("input[name=width]").val(e.width);
            $("input[name=rotate]").val(e.rotate);

        }
    };
    var originalImageURL = $image.attr('src');
    var uploadedImageType = 'image/jpeg';
    var uploadedImageURL;


    // Tooltip
    $('[data-toggle="tooltip"]').tooltip();


    // Cropper
    $image.cropper(options);


    // Buttons
    if (!$.isFunction(document.createElement('canvas').getContext)) {
        $('button[data-method="getCroppedCanvas"]').prop('disabled', true);
    }

    if (typeof document.createElement('cropper').style.transition === 'undefined') {
        $('button[data-method="rotate"]').prop('disabled', true);
        $('button[data-method="scale"]').prop('disabled', true);
    }


    // Download
  /*  if (typeof $download[0].download === 'undefined') {
        $download.addClass('disabled');
    }*/


    // Options
    $('.docs-toggles').on('change', 'input', function () {
        var $this = $(this);
        var name = $this.attr('name');
        var type = $this.prop('type');
        var cropBoxData;
        var canvasData;

        if (!$image.data('cropper')) {
            return;
        }

        if (type === 'checkbox') {
            options[name] = $this.prop('checked');
            cropBoxData = $image.cropper('getCropBoxData');
            canvasData = $image.cropper('getCanvasData');

            options.ready = function () {
                $image.cropper('setCropBoxData', cropBoxData);
                $image.cropper('setCanvasData', canvasData);
            };
        } else if (type === 'radio') {
            options[name] = $this.val();
        }

        $image.cropper('destroy').cropper(options);
    });


    // Methods
    $('.docs-buttons').on('click', '[data-method]', function () {
        var $this = $(this);
        var data = $this.data();
        var $target;
        var result;

        if ($this.prop('disabled') || $this.hasClass('disabled')) {
            return;
        }

        if ($image.data('cropper') && data.method) {
            data = $.extend({}, data); // Clone a new one

            if (typeof data.target !== 'undefined') {
                $target = $(data.target);

                if (typeof data.option === 'undefined') {
                    try {
                        data.option = JSON.parse($target.val());
                    } catch (e) {
                        console.log(e.message);
                    }
                }
            }

            switch (data.method) {
                case 'rotate':
                    $image.cropper('clear');
                    break;

                case 'getCroppedCanvas':
                    if (uploadedImageType === 'image/jpeg') {
                        if (!data.option) {
                            data.option = {};
                        }

                        data.option.fillColor = '#fff';
                    }

                    break;
            }

            result = $image.cropper(data.method, data.option, data.secondOption);

            switch (data.method) {
                case 'rotate':
                    $image.cropper('crop');
                    break;

                case 'scaleX':
                case 'scaleY':
                    $(this).data('option', -data.option);
                    break;

                case 'getCroppedCanvas':
                    if (result) {
                        // Bootstrap's Modal
                        $('#getCroppedCanvasModal').modal().find('.modal-body').html(result);

                     /*   if (!$download.hasClass('disabled')) {
                            $download.attr('href', result.toDataURL(uploadedImageType));
                        }*/
                    }

                    break;

                case 'destroy':
                    if (uploadedImageURL) {
                        URL.revokeObjectURL(uploadedImageURL);
                        uploadedImageURL = '';
                        $image.attr('src', originalImageURL);
                    }

                    break;
            }

            if ($.isPlainObject(result) && $target) {
                try {
                    $target.val(JSON.stringify(result));
                } catch (e) {
                    console.log(e.message);
                }
            }

        }
    });


    // Keyboard
    $(document.body).on('keydown', function (e) {

        if (!$image.data('cropper') || this.scrollTop > 300) {
            return;
        }

        switch (e.which) {
            case 37:
                e.preventDefault();
                $image.cropper('move', -1, 0);
                break;

            case 38:
                e.preventDefault();
                $image.cropper('move', 0, -1);
                break;

            case 39:
                e.preventDefault();
                $image.cropper('move', 1, 0);
                break;

            case 40:
                e.preventDefault();
                $image.cropper('move', 0, 1);
                break;
        }

    });


    // Import image
    var $inputImage = $('#inputImage');

    if (URL) {
        $inputImage.change(function () {
            var files = this.files;
            var file;

            if (!$image.data('cropper')) {
                return;
            }

            if (files && files.length) {
                file = files[0];

                if (/^image\/\w+$/.test(file.type)) {
                    uploadedImageType = file.type;

                    if (uploadedImageURL) {
                        URL.revokeObjectURL(uploadedImageURL);
                    }

                    uploadedImageURL = URL.createObjectURL(file);
                    $image.cropper('destroy').attr('src', uploadedImageURL).cropper(options);
                    //$inputImage.val('');
                } else {
                    window.alert('请上传图片文件');
                }
            }
        });
    } else {
        $inputImage.prop('disabled', true).parent().addClass('disabled');
    }

   /* $('.avatar-form').submit(function () {
        if (!$('.avatar-src').val() && !$inputImage.val()) {
            return false;
        } else {
        ajaxUpload();
        return false;
    }

    });*/


        //var url = $('.avatar-form').attr('action');
        //var data = new FormData($('.avatar-form')[0]);
            $('.avatar-form').ajaxForm({
                dataType: "text",
                beforeSubmit: function () {
                    if (!$('.avatar-src').val() && !$inputImage.val()) {
                        return false;
                    }
                    $(".loading").fadeIn();
            },

            success: function (data) {
                switch (data) {
                    case "0":
                        bootbox.dialog({
                            message : "上传成功",
                            name : "提示",
                            buttons : {
                                add : {
                                    label : "继续上传",
                                    className : "btn-success",
                                    callback : function() {
                                        window.location.reload();
                                    }
                                },
                                list : {
                                    label : "返回列表",
                                    className : "btn-primary",
                                    callback : function() {
                                        var id = $("#hpid").val();
                                        window.location.href="/manage/picture/listPage.htm";
                                    }
                                }
                            }
                        });
                        $("#inputImage").val('');
                        break;

                    case "1":
                        bootbox.alert("请上传图片文件");
                        break;

                    case "2":
                        bootbox.alert("请上传图片");
                        break;

                    case "3":
                        bootbox.alert("系统繁忙，请稍后再试");
                        break;
                }
            },

            error: function (XMLHttpRequest, textStatus, errorThrown) {
                al(textStatus || errorThrown);
            },

            complete: function () {
                $(".loading").fadeOut();
            }
        });

});
