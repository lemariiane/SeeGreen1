<%-- 
    Document   : limite
    Created on : 12 de jun. de 2025, 15:45:58
    Author     : letic
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Limites por Categoria</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .progress {
            height: 25px;
            border-radius: 12px;
        }
        .progress-bar-verde {
            background-color: #4caf50;
        }
        .progress-bar-laranja {
            background-color: #ff9800;
        }
        .progress-bar-vermelho {
            background-color: #f44336;
        }
    </style>
</head>
<body>
    
    <nav class="navbar navbar-expand-lg navbar-light shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="ServletIndex">
            <img src="assets/img/logo.png" alt="SeeGreen" height="40">
            <p class="mb-0 ml-2">SeeGreen</p>
        </a>

        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a href="ServletIndex" class="nav-link">Menu</a>
                </li>
                <li class="nav-item">
                     <a href="AcessarLancamentos" class="nav-link">Lançamentos</a>
                </li>
                <li class="nav-item">
                     <a href="ServletBuscarCategorias" class="nav-link">Minhas Categorias</a>
                </li>
                <li class="nav-item">
                     <a href="ServletLimites" class="nav-link">Limites</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="ServletDeslogar">Sair</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="row align-items-center mb-4">
        <div class="col">
            <h2 class="mb-0">Limites por Categoria</h2>
        </div>
        <div class="col-auto">
            <form method="get" class="row g-2 align-items-center">
                <div class="col-auto">
                    <label for="mes" class="form-label mb-0 me-1">Mês</label>
                    <select id="mes" name="mes" class="form-select">
                        <c:forEach var="m" begin="1" end="12">
                            <option value="${m}" ${m == mesSelecionado ? 'selected' : ''}>
                                ${m}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-auto">
                    <label for="ano" class="form-label mb-0 me-1">Ano</label>
                    <select id="ano" name="ano" class="form-select">
                        <c:forEach var="a" begin="${anoSelecionado - 3}" end="${anoSelecionado + 1}">
                            <option value="${a}" ${a == anoSelecionado ? 'selected' : ''}>${a}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary mt-1">Filtrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

    
    <div class="row gy-4">
        <c:forEach var="item" items="${dados}">
            <c:set var="nome" value="${item.nome}" />
            <c:set var="limite" value="${item.limite}" />
            <c:set var="gasto" value="${item.gasto}" />
            <c:set var="percentual" value="${(limite > 0) ? (gasto / limite * 100) : 0}" />

            <c:choose>
    <c:when test="${percentual <= 60}">
        <c:set var="classeCor" value="progress-bar-verde" />
    </c:when>
    <c:when test="${percentual <= 90}">
        <c:set var="classeCor" value="progress-bar-laranja" />
    </c:when>
    <c:otherwise>
        <c:set var="classeCor" value="progress-bar-vermelho" />
    </c:otherwise>
</c:choose>


            
    <div class="d-flex justify-content-center my-3 px-2">
    <div class="card shadow-sm rounded-4 w-100" style="max-width: 900px; padding: 30px;">
        <div class="card-body">
            <h5 class="card-title">${nome}</h5>
            <p class="card-text mb-3">R$ ${gasto} de R$ ${limite}</p>
            <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                <div class="progress-bar ${classeCor}" style="width: ${percentual}%;">
                    <fmt:formatNumber value="${percentual}" type="number" maxFractionDigits="1" />%
                </div>
            </div>
        </div>
    </div>
</div>




            
            
            </div>

        </c:forEach>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
