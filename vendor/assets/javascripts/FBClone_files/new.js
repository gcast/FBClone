(function() { this.JST || (this.JST = {}); this.JST["threads/new"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('<form>\n\t<div class="styled-select">\n\n\t\t<select name="thread[user_two]" id="recipient">\n\t\n\t\t\t');  friends.each(function(friend) {  ; __p.push('\n   \t\t\t\t<option value="',  friend.id ,'">',  friend.get("first_name") ,'</option>\n   \t\t\t');  }) ; __p.push('\n\t\n  \t\t</select>\n\n  \t</div>\n\n\t<textarea name="thread[first_message]"  placeholder="Write a new message..."></textarea>\n\t<input type="submit" value="Send Message" class="submit new-message-submit">\n</form>\t\n\t\n\n');}return __p.join('');};
}).call(this);
