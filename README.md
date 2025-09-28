# Proyecto de Infraestructura como Código - AWS + Terraform

Integrantes:

- Silva Vega, Héctor Fabrizzio
- Valverde Sihuenza, Wilmer Diego
- John Steven, Alonso Vidal
- Benites Mendoza, Fernando Manuel

## Descripción del Proyecto
Este proyecto consiste en el diseño e implementación de una **infraestructura en AWS utilizando Terraform** para soportar una **plataforma web de reservas en línea** (ej. gimnasio, coworking, consultorios médicos).  
La solución busca ser **escalable, segura y de bajo costo**, aprovechando servicios **serverless** de AWS.

La plataforma incluye:
- **Frontend**: página web estática (ReactJS / HTML, CSS, JS) desplegada en **Amazon S3** y distribuida mediante **CloudFront**.
- **Backend**: API REST desplegada en **AWS Lambda**, expuesta a través de **API Gateway**.
- **Base de Datos**: **Amazon DynamoDB** (serverless, pago por uso).
- **Monitoreo**: integración con **CloudWatch** para métricas y logs; además, el uso de **Amazon SNS** para ermitir que el sistema envíe  **alertas automáticas** a los administradores o usuarios finales cuando ocurran ciertos eventos.
- **Seguridad**: manejo de certificados SSL mediante **ACM** y control de accesos con IAM.

---

## Objetivos
- Implementar una infraestructura en AWS definida completamente como código usando **Terraform**.
- Garantizar una arquitectura **serverless**, escalable y de bajo costo.
- Demostrar el despliegue automatizado de una aplicación web funcional.