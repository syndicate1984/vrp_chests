local cfg = {}

cfg.open_chei = 0

cfg.display_css = [[
	@font-face {
		font-family: 'fontcustom';
		src: url(fonts/fontcustom.woff);
	}

	.div_chei{
		position: absolute;
		top: 108px;
		right: 10px;
		font-size: 17px;
		font-family: fontcustom;
		background: linear-gradient(to left, rgba(255, 255, 255, 0.6), rgba(0,0,0, 0.6));
		background-size: 400%;
		color: white;
		font-weight: bold;
		padding: 0px 3px 0px 3px;
		width : 220px;
		text-align: center;
		border-left: 3px solid white;
		-webkit-animation: AnimationName 5s ease infinite;
		-moz-animation: AnimationName 5s ease infinite;
		animation: AnimationName 5s ease infinite;
		text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
	}
	  .div_coins .symbol{

		content: url('https://media.discordapp.net/attachments/495652333691207680/688862371380199438/Webp.net-resizeimage.png'); 
 
	  }
  
	}
	@-webkit-keyframes AnimationName {
		0%{background-position:0% 50%}
		50%{background-position:50% 0%}
		100%{background-position:0% 50%}
	}
	@-moz-keyframes AnimationName {
		0%{background-position:0% 50%}
		50%{background-position:50% 0%}
		100%{background-position:0% 50%}
	}
	@keyframes AnimationName { 
		0%{background-position:0% 50%}
		50%{background-position:50% 0%}
		100%{background-position:0% 50%}
	}
}
]]

function getcheiConfig()
	return cfg
end
