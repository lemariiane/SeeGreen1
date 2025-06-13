-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 13/06/2025 às 14:04
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `financa`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `cor` varchar(50) NOT NULL,
  `limite` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `categoria`
--

INSERT INTO `categoria` (`id`, `idUsuario`, `categoria`, `cor`, `limite`) VALUES
(2, 3, 'Presentes ', '#ff000d', 1500),
(17, 2, 'Saúde', '#4caf50', 2000),
(21, 4, 'Educação', '#6610f2', 100),
(22, 3, 'plano de saúde', '#81e985', 500),
(25, 7, 'Lazer', '#ffc107', 100),
(26, 7, 'Vestuário', '#d63384', 100),
(27, 2, 'Férias', '#fff700', 3000);

-- --------------------------------------------------------

--
-- Estrutura para tabela `gasto`
--

CREATE TABLE `gasto` (
  `id` int(11) NOT NULL,
  `descricao` text NOT NULL,
  `idCategoria` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `datacadastro` date NOT NULL,
  `valor` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `gasto`
--

INSERT INTO `gasto` (`id`, `descricao`, `idCategoria`, `idUsuario`, `datacadastro`, `valor`) VALUES
(14, 'bn', 2, 3, '2025-07-02', 50),
(15, 'g', 2, 3, '2025-07-02', 2),
(17, 'm', 2, 3, '2025-06-05', 2),
(18, 'Unimed', 22, 3, '2025-06-06', 800),
(19, 'unimed', 17, 2, '2025-06-13', 600),
(21, 'Passagem/hospedagem', 27, 2, '2025-06-13', 2900);

-- --------------------------------------------------------

--
-- Estrutura para tabela `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `login`
--

INSERT INTO `login` (`id`, `email`, `senha`) VALUES
(1, '[testeteste@email.com]', '[12345]'),
(2, 'ma@gmail.com', '123'),
(3, 'leh@gmail.com', '123'),
(4, 'kk@gmail.com', '123'),
(6, 'ju@gmail.com', '123'),
(7, 'oi@gmail.com', '123');

-- --------------------------------------------------------

--
-- Estrutura para tabela `receita`
--

CREATE TABLE `receita` (
  `id` int(11) NOT NULL,
  `descricao` varchar(250) NOT NULL,
  `idTipoReceita` int(11) NOT NULL,
  `valor` double NOT NULL,
  `datareceita` date NOT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `receita`
--

INSERT INTO `receita` (`id`, `descricao`, `idTipoReceita`, `valor`, `datareceita`, `idUsuario`) VALUES
(1, 'bbb', 4, 900, '2025-06-06', 3),
(2, 'extra', 11, 6000, '2024-11-02', 3),
(3, 'ok', 10, 50, '2025-07-02', 3),
(4, 'show', 2, 300, '2025-07-06', 3),
(5, 'salario', 6, 900, '2025-06-06', 3),
(6, 'mensal', 1, 5000, '2025-06-06', 2),
(7, 'show', 2, 3000, '2025-06-10', 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_receita`
--

CREATE TABLE `tipo_receita` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tipo_receita`
--

INSERT INTO `tipo_receita` (`id`, `nome`) VALUES
(4, 'Aposentadoria'),
(11, 'Décimo Terceiro'),
(10, 'Férias'),
(2, 'Freelancer'),
(3, 'Investimentos'),
(12, 'Outros'),
(5, 'Pensão'),
(9, 'Presentes'),
(8, 'Reembolso'),
(1, 'Salário'),
(6, 'Vale alimentação'),
(7, 'Vale transporte');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`idUsuario`);

--
-- Índices de tabela `gasto`
--
ALTER TABLE `gasto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Índices de tabela `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `receita`
--
ALTER TABLE `receita`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_receita_usuario` (`idUsuario`),
  ADD KEY `fk_receita_tipo` (`idTipoReceita`);

--
-- Índices de tabela `tipo_receita`
--
ALTER TABLE `tipo_receita`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de tabela `gasto`
--
ALTER TABLE `gasto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de tabela `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `receita`
--
ALTER TABLE `receita`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `tipo_receita`
--
ALTER TABLE `tipo_receita`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `categoria`
--
ALTER TABLE `categoria`
  ADD CONSTRAINT `id` FOREIGN KEY (`idUsuario`) REFERENCES `login` (`id`);

--
-- Restrições para tabelas `gasto`
--
ALTER TABLE `gasto`
  ADD CONSTRAINT `idCategoria` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `login` (`id`);

--
-- Restrições para tabelas `receita`
--
ALTER TABLE `receita`
  ADD CONSTRAINT `fk_receita_tipo` FOREIGN KEY (`idTipoReceita`) REFERENCES `tipo_receita` (`id`),
  ADD CONSTRAINT `fk_receita_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `login` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
