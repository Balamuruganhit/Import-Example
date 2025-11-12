<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.

-->
<head>
<meta http-equiv="Content-Security-Policy" content="connect-src 'self' https://api.groq.com;">
</head>
<body>
  <div class="main-container-chat" id="tester">
    <aside class="sidebar">
      <h2 class="sidebar-title">Discover</h2>
      <nav class="sidebar-nav">
        <button class="sidebar-button button" data-id="1">Manufacturing Intelligence</button>
        <button class="sidebar-button button" data-id="2">Supply Chain Intelligence</button>
		<button class="sidebar-button button" >Quality Intelligence <span id="nav-arrow" class="navbar-extender"></span></button>
		<span id="arrow">
        <button class="sidebar-button button"  data-id="3">RAM Intelligence</button>
        <button class="sidebar-button button handler"  data-id="4">8D Error Analysis</button>
		<button class="sidebar-button button handler"  data-id="5">5 Why Analysis</button>
		<button class="sidebar-button button handler"  data-id="6">FEMA</button>
		</span>
      </nav>
    </aside>
    <div class="chat-container-bot">
      <header class="chat-header">
        Chat with Pangu
        
      </header>
      <main class="chat-area-bot" id="chat-box-area">
        <textarea id="response" class="chat-message-area bot-res greet">Hi, Welcome To Pangun Tech!</textarea>
        <textarea id="response" class="chat-message-area bot-res greet">"Hello there! How can I assist you today?"</textarea>
        <!-- Messages will be dynamically added here -->
      </main>
      
        <form id="chat-form" class="chat-input-area-user">
              <input id="user-input-area" placeholder="Type your message here..."  type="text"/>
            <input type="submit" id="send-btn-user" value="Send"/>
        </form>
        
      
    </div>
  </div>
</body>
<script>
console.log("working")
	const navArrow=document.getElementById("nav-arrow");
	const arrow=document.getElementById("arrow");
	console.log(navArrow);
	console.log(arrow);
	navArrow.addEventListener("click",()=>{
		arrow.classList.add("show");
		console.log("clicked ")
	})
</script>
<style>
.handler{
	margin-bottom:4px;
}
	#arrow{
		display:none;
		flex-direction:column;
	}
  .navbar-extender {
	display: inline-block;
	width: 0;
	height: 0;
	border-left: 6px solid transparent;
	border-right: 6px solid transparent;
	border-top: 8px solid #000; /* Adjust color */
	}
  .main-container-chat {
	display: flex;
	width: 100%;
	height: 70vh;
	background-color: #ffffff;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.8);
	border-radius: 8px;
	
	overflow: hidden;
	background-size: cover;
  }
  
  .sidebar {
	width: 15%;
	background-color: #2c3e50;
	color: white;
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 20px;
  }
  
  .sidebar-title {
	font-size: 1.5rem;
	margin-bottom: 20px;
  }
  
  .sidebar-nav {
	display: flex;
	flex-direction: column;
	gap: 15px;
	font-size:1.5rem;
  }
  
  .sidebar-button {
	width: 100%;
	padding: 10px 15px;
	background-color: #34495e;
	color: white;
	border: none;
	font-size: 1.4rem;
	text-align: center;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
  }
  
  .sidebar-button:hover {
	background-color: white;
  }
  
  .chat-container-bot{
	width: 85%;
	display: flex;
	flex-direction: column;
	background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url(/rainbowstone/images/panguAiBg.jpg) no-repeat center center;
	background-size:cover;
  }
  
  .chat-header {
	background-color: #0078d4;
	color: #ffffff;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px;
	font-size:1.5rem;
  }
  
 
  
  .chat-area-bot{
	flex: 1;
	padding: 15px;
	overflow-y: auto;
	
  }
  
  .chat-message-area {
	
	margin-bottom: 10px;
	padding: 10px 15px;
	border-radius: 12px;
	
  }
  
  .chat-message-area.user-res {
	background-color: #0078d4;
	color: white;
	line-height: 1.5;
	align-self: flex-end;
	width:95%;
  }
  
  .chat-message-area.bot-res {
	background-color: #e0e0e0;
	color: #333;
	align-self: flex-start;
	
}
  
  .chat-input-area-user {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 15px;
	background-color: #ffffff;
	border-top: 1px solid #e0e0e0;
  }
  
  #user-input-area{
	flex: 1;
    resize: none;
    /* padding: 10px; */
    /* font-size: 1rem; */
    /* width: 100%; */
    border: 1px solid #ddd;
    border-radius: 4px;
    height: 25px;
    outline: none;
  }
  
  .chat-input-area-user input[type='submit'] {
	background-color: #0078d4;
	color: white;
	border: none;
	padding: 10px 20px;
	
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease;
  }
  
  .chat-input-area-user button:hover {
	background-color: #005bb5;
  }
  
  .bot-res{
	width:95%;
	resize:none;
	height:auto;
  }
  .bot-res::-webkit-scrollbar{
	width:0px;
  }
  .chat-area-bot::-webkit-scrollbar{
	width:0px;
  }
  .color{
	background-color: #1abc9c
  }
</style>