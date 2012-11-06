// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function () { $( "#submit_button" ) .click(function() { var name = $("input#author").val(); var content = $("input#content").val(); var data = "http://intense-coast-1179.herokuapp.com/posts/2/comment?author="+name+"&content="+content; $.ajax({ type: "POST", url: data, cache: false, success: function() { $("#commentBox").append("Yay"); } }); poll(); }); }); $(document).ready(function() {poll();}); function poll () { $("#commentBox").load("http://intense-coast-1179.herokuapp.com/posts/2/retrieve #comments"); setTimeout(poll, 1000); };
