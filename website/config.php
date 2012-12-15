<?php
ini_set('arg_separator.output', '&amp;');
ini_set("url_rewriter.tags","a=href, area=href, fieldset=fakeentry, frame=src, iframe=src, input=src");
ini_set('session.use_trans_sid', "0");
ini_set('session.use_only_cookies', "1");
ini_set("url_rewriter.tags","");
?>