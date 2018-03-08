<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ include file="../../common/taglib.jsp" %>

<section class="content">
        <div class="wrapper scrollbar-dynamic">
            <div class="page-content" style="padding-top: 0px; padding-bottom: 0px;">
                <div class="container">
                    <div class="content">
                        <style type="text/css">

                            /*************** SCROLLBAR MAC OS X ***************/

                            .scrollbar-macosx > .scroll-element,
                            .scrollbar-macosx > .scroll-element div
                            {
                                background: none;
                                border: none;
                                margin: 0;
                                padding: 0;
                                position: absolute;
                                z-index: 10;
                            }

                            .scrollbar-macosx > .scroll-element div {
                                display: block;
                                height: 100%;
                                left: 0;
                                top: 0;
                                width: 100%;
                            }

                            .scrollbar-macosx > .scroll-element .scroll-element_track { display: none; }
                            .scrollbar-macosx > .scroll-element .scroll-bar {
                                background-color: #6C6E71;
                                display: block;

                                -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
                                filter: alpha(opacity=0);
                                opacity: 0;

                                -webkit-border-radius: 7px;
                                -moz-border-radius: 7px;
                                border-radius: 7px;

                                -webkit-transition: opacity 0.2s linear;
                                -moz-transition: opacity 0.2s linear;
                                -o-transition: opacity 0.2s linear;
                                -ms-transition: opacity 0.2s linear;
                                transition: opacity 0.2s linear;
                            }
                            .scrollbar-macosx:hover > .scroll-element .scroll-bar,
                            .scrollbar-macosx > .scroll-element.scroll-draggable .scroll-bar {
                                -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=70)";
                                filter: alpha(opacity=70);
                                opacity: 0.7;
                            }


                            .scrollbar-macosx > .scroll-element.scroll-x {
                                bottom: 0px;
                                height: 0px;
                                left: 0;
                                min-width: 100%;
                                overflow: visible;
                                width: 100%;
                            }

                            .scrollbar-macosx > .scroll-element.scroll-y {
                                height: 100%;
                                min-height: 100%;
                                right: 0px;
                                top: 0;
                                width: 0px;
                            }

                            /* scrollbar height/width & offset from container borders */
                            .scrollbar-macosx > .scroll-element.scroll-x .scroll-bar { height: 7px; min-width: 10px; top: -9px; }
                            .scrollbar-macosx > .scroll-element.scroll-y .scroll-bar { left: -9px; min-height: 10px; width: 7px; }

                            .scrollbar-macosx > .scroll-element.scroll-x .scroll-element_outer { left: 2px; }
                            .scrollbar-macosx > .scroll-element.scroll-x .scroll-element_size { left: -4px; }

                            .scrollbar-macosx > .scroll-element.scroll-y .scroll-element_outer { top: 2px; }
                            .scrollbar-macosx > .scroll-element.scroll-y .scroll-element_size { top: -4px; }

                            /* update scrollbar offset if both scrolls are visible */
                            .scrollbar-macosx > .scroll-element.scroll-x.scroll-scrolly_visible .scroll-element_size { left: -11px; }
                            .scrollbar-macosx > .scroll-element.scroll-y.scroll-scrollx_visible .scroll-element_size { top: -11px; }

                        </style>
                        <script type="text/javascript">
                            jQuery(document).ready(function(){
                                jQuery('.scrollbar-macosx').scrollbar();
                            });
                        </script>
                        <div class="demo" style="background-color:white; ">
                            <div class="scrollbar-macosx" style="background-color:white; ">
                                ${agreement}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	<form:form method="POST" modelAttribute="UserInfoForm" style="background-color:transparent; padding:2px;" action="${pageContext.request.contextPath}/registration/agreeAgreement" >
		<form:hidden path="userId" id="userId" />
		<spring:message code="agreeContract"/>
		<input class="btn btn-lg btn-success btn-block" type="button" value="<spring:message code='agree'/>" onclick="agreeAgreement();" >
		<input class="btn btn-lg btn-danger btn-block" type="button" value="<spring:message code='disagree'/>" >
	</form:form>
</section>
<script>

var msg = '${message}';
$(function() {
	if(''!=msg) {
		errorMessage(msg);
	}
});

jQuery(document).ready(function(){
	jQuery('.scrollbar-macosx').scrollbar();
});
	function agreeAgreement() {
		$.ajax({
			url : '${pageContext.request.contextPath}/registration/agreeAgreement?userId=' + $('#userId').val(),
			type : "GET",
			dataType : 'json',
			async: false,
			contentType:"application/json;charset=utf-8", 
			success : function(data) {
                if (data.status === 200) {
                	successMessage("<spring:message code='gotMail'/>");
        			setTimeout(function(){
        				window.location.href = '<%=StringEscapeUtils.escapeHtml(request.getContextPath())%>/login';
        			}, 2000);
                } else {
                    errorMessage(data.message);
                }
			},

			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
			}
		});
	}

	function agreementPdf() {
		window.open("${pageContext.request.contextPath}/registration/agreementPdf?userId=" + $('#userId').val());
	}
</script>
        <script>
            jQuery(function($){

                $('.container').each(function(){

                    var content =  $(this).find('.content');
                    var controls = $(this).find('.controls');

                    controls.on('click', 'span', function(){
                        content.find('.' + $(this).removeClass('active').attr('class')).show().siblings('div').hide();
                        $(this).addClass('active').siblings('span').removeClass('active');
                    });
                    controls.find('.demo').click();
                });

                $('.container').on('click', '.add-content', function(){
                    $('#lorem-ipsum').clone().removeAttr('id').appendTo($(this).closest('.container').find('.scroll-content'));
                    return false;
                });
                $('.container').on('click', '.remove-content', function(){
                    $(this).closest('.container').find('.scroll-content').find('p').not('.permanent').last().remove();
                    return false;
                });

                window.prettyPrint && prettyPrint();
                $('.wrapper').scrollbar();
            });
        </script>
        <style type="text/css" id="css-common">
            /*************** SCROLLBAR BASE CSS ***************/

            .scroll-wrapper {
                overflow: hidden !important;
                padding: 0 !important;
                position: relative;
            }

            .scroll-wrapper > .scroll-content {
                border: none !important;
                box-sizing: content-box !important;
                height: auto;
                left: 0;
                margin: 0;
                max-height: none;
                max-width: none !important;
                overflow: scroll !important;
                padding: 0;
                position: relative !important;
                top: 0;
                width: auto !important;
            }

            .scroll-wrapper > .scroll-content::-webkit-scrollbar {
                height: 0;
                width: 0;
            }

            .scroll-element {
                display: none;
            }
            .scroll-element, .scroll-element div {
                box-sizing: content-box;
            }

            .scroll-element.scroll-x.scroll-scrollx_visible,
            .scroll-element.scroll-y.scroll-scrolly_visible {
                display: block;
            }

            .scroll-element .scroll-bar,
            .scroll-element .scroll-arrow {
                cursor: default;
            }

            .scroll-textarea {
                border: 1px solid #cccccc;
                border-top-color: #999999;
            }
            .scroll-textarea > .scroll-content {
                overflow: hidden !important;
            }
            .scroll-textarea > .scroll-content > textarea {
                border: none !important;
                box-sizing: border-box;
                height: 100% !important;
                margin: 0;
                max-height: none !important;
                max-width: none !important;
                overflow: scroll !important;
                outline: none;
                padding: 2px;
                position: relative !important;
                top: 0;
                width: 100% !important;
            }
            .scroll-textarea > .scroll-content > textarea::-webkit-scrollbar {
                height: 0;
                width: 0;
            }




        </style>