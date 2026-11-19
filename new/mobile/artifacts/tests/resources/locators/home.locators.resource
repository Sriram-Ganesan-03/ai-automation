*** Variables ***
# Home, Offers, and bottom-navigation locators
${HOME_VIEW_MY_OFFERS_BUTTON}      xpath=//*[contains(translate(@text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'VIEW MY OFFERS') or contains(translate(@content-desc,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'VIEW MY OFFERS')]
${HOME_ALL_PROMOS_BUTTON}          xpath=//*[contains(translate(@text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'ALL PROMOS') or contains(translate(@content-desc,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'ALL PROMOS')]
${HOME_DASHBOARD_MARKER}           xpath=//*[contains(translate(@text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'POINT BALANCE') or contains(translate(@content-desc,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'POINT BALANCE')]
${OFFERS_SCREEN_MARKER}            xpath=//*[contains(translate(@text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'OFFERS') or contains(translate(@content-desc,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'OFFERS') or contains(translate(@pane-title,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'OFFERS') or contains(translate(@pane-title,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'PROMOTIONS') or contains(translate(@text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'PROMOTIONS')]
${OFFERS_BACK_BUTTON}              xpath=//*[@content-desc='<' or @text='<' or @content-desc='Navigate up' or @content-desc='Back']
@{HOME_OFFERS_POINT}               274    322
