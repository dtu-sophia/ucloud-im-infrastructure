<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>

    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" class="${properties.kcFormClass!}" >
                <#if !usernameHidden??>
                
                <!--
                    <div class="${properties.kcFormGroupClass!}">
                        <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                        />
                       


                        <#if messagesPerField.existsError('username','password')>
                            <span class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>

                    </div>
                    -->
                    
                    
                    <label class="mdc-text-field mdc-text-field--outlined" data-mdc-auto-init="MDCTextField" >
			  <span class="mdc-notched-outline">
			    <span class="mdc-notched-outline__leading"></span>
			    <span class="mdc-notched-outline__notch">
			      <span class="mdc-floating-label" ><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></span>
			    </span>
			    <span class="mdc-notched-outline__trailing"></span>
			  </span> 
			  <input tabindex="1" id="username" name="username" type="text" class="mdc-text-field__input" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" autocomplete="off"  >
		   </label>
		                
                        
                </#if>

          <!--  <div class="${properties.kcFormGroupClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>

                    <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                    />

                    <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                        <span class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                    </#if>

                </div>
                -->
                
                  
                
                    <label class="mdc-text-field mdc-text-field--outlined" data-mdc-auto-init="MDCTextField" >
			  <span class="mdc-notched-outline">
			    <span class="mdc-notched-outline__leading"></span>
			    <span class="mdc-notched-outline__notch">
			      <span class="mdc-floating-label" >${msg("password")}</span>
			    </span>
			    <span class="mdc-notched-outline__trailing"></span>
			  </span> 
			  <input tabindex="2" id="password" name="password" type="password" class="mdc-text-field__input" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"  autocomplete="off"  >
		   </label>       
                
                      
                            <span class="${properties.kcInputErrorMessageClass!} mdc-text-field-helper-text--validation-msg" aria-live="polite">
                            <#if messagesPerField.existsError('username','password')>        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc} </#if>
                            </span>
                       
                        
			
			
			
			
          <!--      <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                        <div id="kc-form-options">
                    
                        <#if realm.rememberMe && !usernameHidden??>
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                    </#if>
                                </label>
                            </div>
                        </#if>
                        </div>
                        
                        
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <#if realm.resetPasswordAllowed>
                                <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                            </#if>
                        </div>  

                  </div>  -->

                 <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
          <!--             <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                     <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>  -->
                      
                       <button tabindex="4" class="${properties.kcLoginButtonClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}" >
			  <span class="mdc-button__ripple"></span>
			  <span class="mdc-button__label">${msg("doLogIn")}</span>
			</button>  
			
			<#if realm.resetPasswordAllowed>
			<span class="${properties.kcLoginForgotButton!}"><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
			</#if>
			
                 </div>  
            </form>
            
        
         
         
        </#if>
        </div>
        

        
         <p class="${properties.kcLoginExtra!}"> ${kcSanitize(msg("extraplogin"))}</p>
         
         
         <button class="mdc-button ${properties.kcLoginTerms!}" onclick="toggleDialog(event)" >
	   <span class="mdc-button__label">${kcSanitize(msg("termsTitle"))} </span>
	</button>
	
	
	

    </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>



</@layout.registrationLayout>




<!-- at the bottom of the page -->

<script type="text/javascript">

  let toggleDialog = (el) => {
        event.preventDefault();
  	window.open("${properties.kcLoginTermsPopup!}", "General Terms", "popup=yes,noopener=yes,noreferrer=yes,left=600,top=300,width=500,height=500" );
  	return 1;
  }
  
</script>

