<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: psn14020
  Date: 2015-03-04
  Time: 오전 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <style>
        body {
            padding-top: 40px;
            padding-bottom: 40px;
        }
        #chat {
            border :1px solid #31b0d5;
            height:300px;
            overflow:auto;
        }

        #seat th {
            text-align:center;
            cursor:pointer;
        }

        #seat th:hover {
            background-color: #e8e8e8;
        }
    </style>
    <script type="text/javascript" src="/resources/js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/resources/js/sockJs.js"></script>
    <script type="text/javascript" src="/resources/js/stomp.js"></script>
</head>
<body>
<security:authentication property="principal.username" var="id"/>
<div class="container">
    <input type="text" class="form-control" placeholder="Nick Name" id="nickName" value="${id}">
    <div id="chat">
    </div>
    <div class="form-group has-success has-feedback">
        <label class="control-label sr-only" for="message">Input group with success</label>
        <div class="input-group">
            <input type="text" class="form-control" id="message">
            <span id="sendBtn" class="input-group-addon btn btn-default">전송</span>
        </div>
    </div>
</div>
<script>
    var ws = new SockJS("/ws");
    var stompClient = Stomp.over(ws);
    stompClient.connect([], function(frame) {
        console.log(frame);
        stompClient.subscribe("/topic/message", function(res) {
            var json = JSON.parse(res.body);
            var p = $('<p>').text(json.id + " : " + json.msg);
            $('#chat').append(p);
            $('#chat').scrollTop($('#chat')[0].scrollHeight);
        })
    })

    $.msgSend = function() {
        var msg = $('#message').val();
        stompClient.send("/app/message", {}, JSON.stringify({"id":'${id}', "msg":msg}));
        $('#message').val("");
    }

    $('#sendBtn').click(function() {
        $.msgSend();
    })

    $('#message').keyup(function(e) {
        if(e.keyCode == 13) {
            $.msgSend();
        }
    })

</script>
</body>
</html>
