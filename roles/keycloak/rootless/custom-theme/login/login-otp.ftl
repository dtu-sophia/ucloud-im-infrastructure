<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="header">
        ${msg("doLogIn")}
    <#elseif section="form">
        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
            method="post">
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcInputWrapperClass!}">
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <input id="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListInputClass!}" type="radio" name="selectedCredentialId" value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if>>
                            <label for="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListClass!}" tabindex="${otpCredential?index}">
                                <span class="${properties.kcLoginOTPListItemHeaderClass!}">
                                    <span class="${properties.kcLoginOTPListItemIconBodyClass!}">
                                      <i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i>
                                    </span>
                                    <span class="${properties.kcLoginOTPListItemTitleClass!}">${otpCredential.userLabel}</span>
                                </span>
                            </label>
                        </#list>
                    </div>
                </div>
            </#if>

       <!--     <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="otp" class="${properties.kcLabelClass!}">${msg("loginOtpOneTime")}</label>
                </div>

		    <div class="${properties.kcInputWrapperClass!}">
		        <input id="otp" name="otp" autocomplete="off" type="text" class="${properties.kcInputClass!}"
		               autofocus aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"/>

		        <#if messagesPerField.existsError('totp')>
		            <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}"
		                  aria-live="polite">
		                ${kcSanitize(messagesPerField.get('totp'))?no_esc}
		            </span>
		        </#if>
		    </div>
            </div>   -->
            
                       <label class="mdc-text-field mdc-text-field--outlined dark" data-mdc-auto-init="MDCTextField" >
			  <span class="mdc-notched-outline">
			    <span class="mdc-notched-outline__leading"></span>
			    <span class="mdc-notched-outline__notch">
			      <span class="mdc-floating-label" >${msg("authenticatorCode")}</span>
			    </span>
			    <span class="mdc-notched-outline__trailing"></span>
			  </span> 
			  <input id="otp" name="otp" type="text" autocomplete="off" class="mdc-text-field__input" aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"  required >
		   	</label>   
		                              
            
                            <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!} mdc-text-field-helper-text--validation-msg" aria-live="polite">
                            <#if messagesPerField.existsError('totp')> ${kcSanitize(messagesPerField.get('totp'))?no_esc}  </#if>
                            </span>               
            
            

      <!--      <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input
                        class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                        name="login" id="kc-login" type="submit" value="${msg("doLogIn")}" />
                </div>
            </div>     -->
            
                       <button class="${properties.kcLoginButtonClass!} dark" id="kc-login" type="submit" value="${msg("doLogIn")} onclick="loading(this)" >
			  <span class="mdc-button__ripple"></span>
			  <span class="mdc-button__label">${msg("doLogIn")}</span>
			</button>             
            
            
            
            
        </form>
    </#if>
</@layout.registrationLayout>

<script>
  let loading = (event) => {
  	  event.preventDefault();
  	  document.querySelector("body").classList.toggle("fade-out");
	  document.querySelector(".loading-box").classList.toggle("fade-in");
	  
	  await new Promise(r => setTimeout(r, 2000));
	  
	  document.querySelector('form').submit();
  }

</script>
