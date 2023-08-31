<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
        <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                   readonly="readonly" style="display:none;"/>
            <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

          <!--  <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-new" class="${properties.kcLabelClass!}">${msg("passwordNew")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password-new" name="password-new" class="${properties.kcInputClass!}"
                           autofocus autocomplete="new-password"
                           aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                    />

                    <#if messagesPerField.existsError('password')>
                        <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>
            
            -->
            
            
                  <label class="mdc-text-field mdc-text-field--outlined dark ${properties.kcForgetEmailInputClass!}" data-mdc-auto-init="MDCTextField" >
			  <span class="mdc-notched-outline">
			    <span class="mdc-notched-outline__leading"></span>
			    <span class="mdc-notched-outline__notch">
			      <span class="mdc-floating-label" >${msg("passwordNew")}</span>
			    </span>
			    <span class="mdc-notched-outline__trailing"></span>
			  </span> 
			  <input id="password-new" name="password-new" type="password" autofocus autocomplete="new-password" class="mdc-text-field__input" aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>" >
		   </label>   
                  
            
            
            
            

     <!--       <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password-confirm" name="password-confirm"
                           class="${properties.kcInputClass!}"
                           autocomplete="new-password"
                           aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                    />

                    <#if messagesPerField.existsError('password-confirm')>
                        <span id="input-error-password-confirm" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                        </span>
                    </#if>

                </div>
            </div>  -->
            
            
             <label class="mdc-text-field mdc-text-field--outlined dark ${properties.kcForgetEmailInputClass!}" data-mdc-auto-init="MDCTextField" >
			  <span class="mdc-notched-outline">
			    <span class="mdc-notched-outline__leading"></span>
			    <span class="mdc-notched-outline__notch">
			      <span class="mdc-floating-label" >${msg("passwordConfirm")}</span>
			    </span>
			    <span class="mdc-notched-outline__trailing"></span>
			  </span> 
			  <input id="password-confirm" name="password-confirm" autocomplete="new-password" type="password" class="mdc-text-field__input" aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>" >
		   </label>   
            
  
              <span class="${properties.kcInputErrorMessageClass!} mdc-text-field-helper-text--validation-msg" aria-live="polite">
                            <#if messagesPerField.existsError('password', 'password-confirm')> ${kcSanitize(messagesPerField.get('password'))?no_esc} ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}  </#if>
                            </span>
  
            

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <#if isAppInitiatedAction??>
                            <div class="checkbox">
                                <label><input type="checkbox" id="logout-sessions" name="logout-sessions" value="on" checked> ${msg("logoutOtherSessions")}</label>
                            </div>
                        </#if>
                    </div>
                </div>

       <!--         <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <#if isAppInitiatedAction??>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                        <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                    <#else>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                    </#if>
                </div>  -->
                
                
                    <#if isAppInitiatedAction??>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                        <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                    <#else>                
                    <button class="${properties.kcLoginButtonClass!} dark" type="submit" value="${msg("doSubmit")} >
			  <span class="mdc-button__ripple"></span>
			  <span class="mdc-button__label">${msg("doSubmit")}</span>
			</button> 
			
			
		   </#if> 
                
                
            </div>
        </form>
    </#if>
</@layout.registrationLayout>



