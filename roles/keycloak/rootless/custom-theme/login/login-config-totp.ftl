<#import "template.ftl" as layout>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>

    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
        <ol id="kc-totp-settings" >
            <li>
                <p>${msg("loginTotpStep1")}</p>

                <ul id="kc-totp-supported-apps">
                    <#list totp.policy.supportedApplications as app>
                        <li>${app}</li>
                    </#list>
                </ul>
            </li>

            <#if mode?? && mode = "manual">
                <li>
                    <p>${msg("loginTotpManualStep2")}</p>
                    <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                    <p><a href="${totp.qrUrl}" id="mode-barcode"  class="highlight" >${msg("loginTotpScanBarcode")}</a></p>
                </li>
                <li>
                    <p>${msg("loginTotpManualStep3")}</p>
                    <p>
                    <ul>
                        <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                        <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                        <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                        <#if totp.policy.type = "totp">
                            <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                        <#elseif totp.policy.type = "hotp">
                            <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                        </#if>
                    </ul>
                    </p>
                </li>
            <#else>
                <li>
                    <p>${msg("loginTotpStep2")}</p>
                    <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                    <p><a href="${totp.manualUrl}" id="mode-manual" class="highlight" >${msg("loginTotpUnableToScan")}</a></p>
                </li>
            </#if>
            <li>
                <p>${msg("loginTotpStep3")}</p>
                <p>${msg("loginTotpStep3DeviceName")}</p>
            </li>
        </ol>

        <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
            <div class="${properties.kcFormGroupClass!}">
         <!--        <div class="${properties.kcInputWrapperClass!}">
                    <label for="totp" class="control-label">${msg("authenticatorCode")}</label> <span class="required">*</span>
                </div>
                
                  <div class="${properties.kcInputWrapperClass!}">
                 <input type="text" id="totp" name="totp" autocomplete="off" class="${properties.kcInputClass!}"
                           aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                    />  
                    
                    <#if messagesPerField.existsError('totp')>
                        <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                        </span>
                    </#if>

  		</div>    -->
  		
                       <label class="mdc-text-field mdc-text-field--outlined dark ${properties.kcForgetEmailInputClass!}" data-mdc-auto-init="MDCTextField" >
			  <span class="mdc-notched-outline">
			    <span class="mdc-notched-outline__leading"></span>
			    <span class="mdc-notched-outline__notch">
			      <span class="mdc-floating-label" >${msg("authenticatorCode")}</span>
			    </span>
			    <span class="mdc-notched-outline__trailing"></span>
			  </span> 
			  <input id="totp" name="totp" type="text" autocomplete="off" class="mdc-text-field__input" aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"  required >
		   	</label>   
		                  

                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
            </div>


     <!--       <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <label for="userLabel" class="control-label">${msg("loginTotpDeviceName")}</label> <#if totp.otpCredentials?size gte 1><span class="required">*</span></#if>
                </div>

                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" class="${properties.kcInputClass!}" id="userLabel" name="userLabel" autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>"
                    />

                    <#if messagesPerField.existsError('userLabel')>
                        <span id="input-error-otp-label" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>   -->
            
  
                         <label class="mdc-text-field mdc-text-field--outlined dark ${properties.kcForgetEmailInputClass!}" data-mdc-auto-init="MDCTextField" >
			  <span class="mdc-notched-outline">
			    <span class="mdc-notched-outline__leading"></span>
			    <span class="mdc-notched-outline__notch">
			      <span class="mdc-floating-label" >${msg("loginTotpDeviceName")}</span>
			    </span>
			    <span class="mdc-notched-outline__trailing"></span>
			  </span> 
			  <input id="userLabel" name="userLabel" type="text" autocomplete="off" class="mdc-text-field__input" aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>" >
		   	</label>   
            
                          <!--  <span id="input-error-otp-label" class="${properties.kcInputErrorMessageClass!} mdc-text-field-helper-text--validation-msg" aria-live="polite">
                            <#if messagesPerField.existsError('totp')> ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}  </#if>
                            </span>  -->
                            
                           <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!} mdc-text-field-helper-text--validation-msg" aria-live="polite">
                            <#if messagesPerField.existsError('totp')> ${kcSanitize(messagesPerField.get('totp'))?no_esc}  </#if>
                            </span>                           
                            
            <#if isAppInitiatedAction??>
          <!--      <input type="submit"
                       class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}"
                       id="saveTOTPBtn" value="${msg("doSubmit")}"
                /> -->
                

                       <button class="${properties.kcLoginButtonClass!} dark" id="saveTOTPBtn" type="submit" value="${msg("doSubmit")} >
			  <span class="mdc-button__ripple"></span>
			  <span class="mdc-button__label">${msg("doSubmit")}</span>
			</button>                  
                
                
                
             <!--   <button type="submit"
                        class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!} ${properties.kcButtonLargeClass!}"
                        id="cancelTOTPBtn" name="cancel-aia" value="true" />${msg("doCancel")}
                </button>  -->
                
                       <button class="${properties.kcLoginButtonClass!} dark" id="cancelTOTPBtn" type="submit" name="cancel-aia" value="true" value="${msg("doCancel")} >
			  <span class="mdc-button__ripple"></span>
			  <span class="mdc-button__label">${msg("doCancel")}</span>
			</button>                    
                
                
                
                
                
            <#else>
        <!--        <input type="submit"
                       class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                       id="saveTOTPBtn" value="${msg("doSubmit")}"
                /> -->
                
                       <button class="${properties.kcLoginButtonClass!} dark" id="saveTOTPBtn" type="submit" value="${msg("doSubmit")} >
			  <span class="mdc-button__ripple"></span>
			  <span class="mdc-button__label">${msg("doSubmit")}</span>
			</button>                     
                
                
            </#if>
        </form>
    </#if>
</@layout.registrationLayout>




<!-- at the bottom of the page -->

<script type="text/javascript">
  window.mdc.autoInit();
</script>
