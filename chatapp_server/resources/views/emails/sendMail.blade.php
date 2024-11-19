<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>رمز التحقق من بريدك الإلكتروني</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7f6;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            padding-bottom: 20px;
        }
        .header h1 {
            font-size: 24px;
            color: #2C3E50;
        }
        .body {
            font-size: 16px;
            line-height: 1.5;
            color: #555;
        }
        .verification-code {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            font-size: 22px;
            font-weight: bold;
            border-radius: 6px;
            margin: 15px 0;
        }
        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
            color: #7f8c8d;
        }
        .footer a {
            color: #3498db;
            text-decoration: none;
        }
        .footer p {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>{{ $title }}</h1>
        </div>
        
        <div class="body">
            <p>{{ $body }}</p>
            <p class="verification-code">{{ $code }}</p>
            <p>الرجاء إدخال الرمز أعلاه في التطبيق للتحقق من بريدك الإلكتروني.</p>
        </div>
        
        <div class="footer">
            <p>إذا لم تكن قد طلبت هذا الرمز، يرجى تجاهل هذا البريد الإلكتروني.</p>
            <p>شكراً لاستخدامك خدمتنا!</p>
            <p>فريق الدعم</p>
        </div>
    </div>
</body>
</html>
