<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <form id="kc-reset-password-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
        <!--  <div class="${properties.kcFormGroupClass!}">
            
              
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                </div>
                
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="username" name="username" class="${properties.kcInputClass!}" autofocus value="${(auth.attemptedUsername!'')}" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                    <#if messagesPerField.existsError('username')>
                        <span id="input-error-username" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('username'))?no_esc}
                        </span>
                    </#if>
                </div>
                
              </div>   -->
                
                     <label class="mdc-text-field mdc-text-field--outlined dark ${properties.kcForgetEmailInputClass!}" data-mdc-auto-init="MDCTextField" >
			  <span class="mdc-notched-outline">
			    <span class="mdc-notched-outline__leading"></span>
			    <span class="mdc-notched-outline__notch">
			      <span class="mdc-floating-label" >${msg("usernameOrEmail")}</span>
			    </span>
			    <span class="mdc-notched-outline__trailing"></span>
			  </span> 
			  <input autofocus id="username" name="username" type="text" class="mdc-text-field__input" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" >
		   </label>   
		                  
                            <span class="${properties.kcInputErrorMessageClass!} mdc-text-field-helper-text--validation-msg" aria-live="polite">
                            <#if messagesPerField.existsError('username')> ${kcSanitize(messagesPerField.get('username'))?no_esc}  </#if>
                            </span>
                            
                
            

<!--
                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}"/>
                </div>
-->


                

            <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                       <button class="${properties.kcLoginButtonClass!} dark" name="login" id="kc-login" type="submit" value="${msg("doSubmit")} >
			  <span class="mdc-button__ripple"></span>
			  <span class="mdc-button__label">${msg("doSubmit")}</span>
			</button>  
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                    </div>
                </div>


                
            </div>
        </form>
    <#elseif section = "info" >
        <#if realm.duplicateEmailsAllowed>
            ${msg("emailInstructionUsername")}
        <#else>
            ${msg("emailInstruction")}
        </#if>
    </#if>
</@layout.registrationLayout>


