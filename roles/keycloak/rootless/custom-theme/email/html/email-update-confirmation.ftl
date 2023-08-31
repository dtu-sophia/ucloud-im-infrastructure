<html>
<body>
${kcSanitize(msg("emailUpdateConfirmationBodyHtml",link, newEmail, realmName, linkExpirationFormatter(linkExpiration)))?no_esc}



<p style="font-size: 11.5px; font-family: Arial; margin: 0px; line-height: 17px">&nbsp;</p>
<table border="0" cellspacing="0" cellpadding="0" style="padding: 0px; width: 400px;">
    <tr>
        <td style="width: 400px;">
            <table border="0" cellspacing="0" cellpadding="0" style="width: 400px; font-family: Arial; font-size: 11.5px; color: Black; border-collapse: collapse">
                <tr>
                    <td valign="top" style="width: 50px; vertical-align: top;">
                        <table cellspacing="0" cellpadding="0" style="width: 50px; padding-top:4px;">
                            <tr>
                                <td align="left" style="width: 50px; text-align: left; vertical-align: top;">
                                    <img width="36" height="53" src="${properties.sigLogo!}" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top" style="width: 350px; vertical-align: top">
                        <table border="0" cellspacing="0" cellpadding="0" style="width: 350px; font-family: Arial; font-size: 11.5px; color: Black; border-collapse: collapse">                           
                            <tr>
                                <td style="width: 350px; font-size: 16px; margin: 0px; line-height: 17px; font-family: Arial; font-weight: bold; line-height:120%;">${properties.sigAuthor!}</td>
                            </tr>
                            <tr>
                                <td style="width: 350px; font-size: 11.5px; font-family: Arial; margin: 0px; line-height: 17px;">${properties.sigFunction!}</td>
                            </tr>
                            <tr>
                                <td style="width: 350px; font-size: 11.5px; font-family: Arial; margin: 0px; line-height: 17px">&nbsp;</td>
                            </tr>
                            <tr><td style="width: 350px; font-size: 11.5px; font-family: Arial; margin: 0px; line-height: 17px">${properties.sigPhone!}</td></tr>
                            <tr>
                                <td style="width: 350px; line-height: 17px;">
                                    <a style="font-size: 11.5px; font-family: Arial; margin: 0px; line-height: 17px; color:black; text-decoration: none;" href="mailto:${properties.sigEmail!}">${properties.sigEmail!}</a>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 350px; font-size: 11.5px; font-family: Arial; margin: 0px; line-height: 17px">${properties.sigAdd1!}</td>
                            </tr>
                            <tr>
                                <td style="width: 350px; font-size: 11.5px; font-family: Arial; margin: 0px; line-height: 17px">${properties.sigAdd2!}</td>
                            </tr>
                            <tr>
                                <td style="width: 350px; font-size: 11.5px; font-family: Arial; margin: 0px; line-height: 17px">${properties.sigAdd3!}</td>
                            </tr>
                            <tr>
                                <td style="width: 350px; line-height: 17px;">
                                    <a style="font-size: 11.5px; font-family: Arial; margin: 0px; line-height: 17px; color:black; text-decoration: none;" href="${properties.sigWebsite!}">${properties.sigWebsite!}</a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</body>
</html>
