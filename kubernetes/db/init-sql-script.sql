DO $$
BEGIN
    -- Verifica e cria TBL_CLIENTE
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'tbl_cliente') THEN
        CREATE TABLE public.TBL_CLIENTE (
            ID serial PRIMARY KEY,
            NOME VARCHAR(255),
            CPF VARCHAR(11),
            EMAIL VARCHAR(255),
            DATA DATE
        );
    END IF;

    -- Verifica e cria TBL_CATEGORIA
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'tbl_categoria') THEN
        CREATE TABLE public.TBL_CATEGORIA (
            ID serial PRIMARY KEY,
            NOME VARCHAR(255)
        );
    END IF;

    -- Verifica e cria TBL_ACOMPANHAMENTO
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'tbl_acompanhamento') THEN
        CREATE TABLE public.TBL_ACOMPANHAMENTO (
            ID serial PRIMARY KEY,
            NOME VARCHAR(255)
        );
    END IF;

    -- Verifica e cria TBL_PRODUTO
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'tbl_produto') THEN
        CREATE TABLE public.TBL_PRODUTO (
            ID serial PRIMARY KEY,
            NOME VARCHAR(255),
            PRECO NUMERIC(10, 2),
            DESCRICAO TEXT,
            URL_IMAGEM VARCHAR(255),
            ID_CATEGORIA INT REFERENCES public.TBL_CATEGORIA(ID)
        );
    END IF;

    -- Verifica e cria TBL_METODO_PAGAMENTO
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'tbl_metodo_pagamento') THEN
        CREATE TABLE public.TBL_METODO_PAGAMENTO (
            ID serial PRIMARY KEY,
            NOME VARCHAR(255)
        );
    END IF;

    -- Verifica e cria TBL_PAGAMENTO
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'tbl_pagamento') THEN
        CREATE TABLE public.TBL_PAGAMENTO (
            ID serial PRIMARY KEY,
            ID_PEDIDO INT,
            ID_METODO INT REFERENCES public.TBL_METODO_PAGAMENTO(ID), 
            VALOR NUMERIC(10, 2),  
            DATA_CRIACAO DATE,
            DATA_ATUALIZACAO DATE
        );
    END IF;

    -- Verifica e cria TBL_PEDIDO
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'tbl_pedido') THEN
        CREATE TABLE public.TBL_PEDIDO (
            ID serial PRIMARY KEY,
            ID_CLIENTE INT REFERENCES public.TBL_CLIENTE(ID),
            DATA DATE,
            ID_ACOMPANHAMENTO INT REFERENCES public.TBL_ACOMPANHAMENTO(ID),
            ID_PAGAMENTO INT REFERENCES public.TBL_PAGAMENTO(ID)
        );
    END IF;

    -- Verifica e cria TBL_PRODUTOS_PEDIDO
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'tbl_produtos_pedido') THEN
        CREATE TABLE public.TBL_PRODUTOS_PEDIDO (
            ID serial PRIMARY KEY,
            ID_PEDIDO INT REFERENCES public.TBL_PEDIDO(ID),
            ID_PRODUTO INT REFERENCES public.TBL_PRODUTO(ID),
            QUANTIDADE INT
        );
    END IF;
END $$;

-- Inserir dados básicos se as tabelas estiverem vazias
DO $$
BEGIN
    -- Inserir em TBL_METODO_PAGAMENTO
    IF (SELECT COUNT(*) FROM public.TBL_METODO_PAGAMENTO) = 0 THEN
        INSERT INTO public.TBL_METODO_PAGAMENTO (NOME) VALUES
        ('MercadoPagoQRCode');
    END IF;
    
    -- Inserir em TBL_CLIENTE
    IF (SELECT COUNT(*) FROM public.TBL_CLIENTE) = 0 THEN
        INSERT INTO public.TBL_CLIENTE (NOME, CPF, EMAIL, DATA) VALUES
        ('João Silva', '12345678901', 'joao@email.com', '2023-01-15'),
        ('Maria Santos', '98765432101', 'maria@email.com', '2023-05-20'),
        ('Pedro Souza', '45678912301', 'pedro@email.com', '2023-11-10'),
        ('Ana Oliveira', '78912345601', 'ana@email.com', '2023-07-02'),
        ('Carlos Pereira', '32165498701', 'carlos@email.com', '2023-09-25');
    END IF;

    -- Inserir em TBL_CATEGORIA
    IF (SELECT COUNT(*) FROM public.TBL_CATEGORIA) = 0 THEN
        INSERT INTO public.TBL_CATEGORIA (NOME) VALUES
        ('Lanche'),
        ('Acompanhamento'),
        ('Bebida'),
        ('Sobremesa');
    END IF;
    
    -- Inserir em TBL_ACOMPANHAMENTO
    IF (SELECT COUNT(*) FROM public.TBL_ACOMPANHAMENTO) = 0 THEN
        INSERT INTO public.TBL_ACOMPANHAMENTO (NOME) VALUES
        ('Criado'),
        ('Recebido'),
        ('Em preparação'),
        ('Pronto'),
        ('Finalizado');
    END IF;
    
    -- Inserir registros fictícios em TBL_PRODUTO
    -- Inserir em TBL_ACOMPANHAMENTO
    IF (SELECT COUNT(*) FROM public.TBL_PRODUTO) = 0 THEN
        INSERT INTO TBL_PRODUTO (NOME, PRECO, DESCRICAO, URL_IMAGEM, ID_CATEGORIA) VALUES
        ('Hambúrguer', 9.99, 'Hambúrguer delicioso', 'https://example.com/imagem1.jpg', 1),
        ('Batata Frita', 4.99, 'Batata frita crocante', 'https://example.com/imagem2.jpg', 2),
        ('Coca-Cola', 2.99, 'Refrigerante refrescante', 'https://example.com/imagem3.jpg', 3),
        ('Sundae de Chocolate', 3.99, 'Sobremesa de chocolate', 'https://example.com/imagem4.jpg', 4),
        ('Salada Caesar', 7.99, 'Salada de frango caesar', 'https://example.com/imagem5.jpg', 2),
        ('Pizza de Pepperoni', 12.99, 'Pizza com pepperoni', 'https://example.com/imagem6.jpg', 1),
        ('Onion Rings', 5.99, 'Anéis de cebola fritos', 'https://example.com/imagem7.jpg', 2),
        ('Sprite', 2.99, 'Refrigerante de limão-limão', 'https://example.com/imagem8.jpg', 3),
        ('Cheesecake de Morango', 4.99, 'Cheesecake com morangos', 'https://example.com/imagem9.jpg', 4),
        ('Taco de Frango', 8.99, 'Taco de frango picante', 'https://example.com/imagem10.jpg', 1),
        ('Milkshake de Baunilha', 3.99, 'Milkshake de baunilha cremoso', 'https://example.com/imagem11.jpg', 3),
        ('Creme Brulee', 6.99, 'Sobremesa de creme queimado', 'https://example.com/imagem12.jpg', 4),
        ('Wrap de Alface', 7.99, 'Wrap de frango em folha de alface', 'https://example.com/imagem13.jpg', 2),
        ('Água Mineral', 1.99, 'Água mineral pura', 'https://example.com/imagem14.jpg', 3),
        ('Torta de Maçã', 5.99, 'Torta de maçã caseira', 'https://example.com/imagem15.jpg', 4),
        ('Muffin de Blueberry', 3.49, 'Muffin com blueberries', 'https://example.com/imagem16.jpg', 4),
        ('Cachorro-Quente', 6.99, 'Cachorro-quente clássico', 'https://example.com/imagem17.jpg', 1),
        ('Fritas de Queijo', 5.49, 'Fritas de queijo derretido', 'https://example.com/imagem18.jpg', 2),
        ('Pepsi', 2.99, 'Refrigerante de cola', 'https://example.com/imagem19.jpg', 3),
        ('Bolo de Chocolate', 4.99, 'Bolo de chocolate decadente', 'https://example.com/imagem20.jpg', 4),
        ('Sushi de Salmão', 11.99, 'Sushi de salmão fresco', 'https://example.com/imagem21.jpg', 1),
        ('Sorvete de Baunilha', 4.49, 'Sorvete de baunilha cremoso', 'https://example.com/imagem22.jpg', 4),
        ('Sanduíche de Frango', 7.49, 'Sanduíche de frango grelhado', 'https://example.com/imagem23.jpg', 1),
        ('Tiramisu', 6.99, 'Sobremesa de café italiana', 'https://example.com/imagem24.jpg', 4),
        ('Nuggets de Frango', 4.99, 'Nuggets de frango crocantes', 'https://example.com/imagem25.jpg', 2),
        ('Fanta', 2.99, 'Refrigerante de laranja', 'https://example.com/imagem26.jpg', 3),
        ('Bolo de Morango', 4.99, 'Bolo de morango fresco', 'https://example.com/imagem27.jpg', 4),
        ('Tacos de Peixe', 9.99, 'Tacos de peixe com molho de pimenta', 'https://example.com/imagem28.jpg', 1),
        ('Sorvete de Chocolate', 4.49, 'Sorvete de chocolate indulgente', 'https://example.com/imagem29.jpg', 4),
        ('Sanduíche Vegetariano', 7.49, 'Sanduíche vegetariano saudável', 'https://example.com/imagem30.jpg', 1);
    END IF;

    IF (SELECT COUNT(*) FROM public.TBL_PEDIDO) = 0 THEN
        INSERT INTO TBL_PEDIDO (ID_CLIENTE, DATA, ID_ACOMPANHAMENTO) VALUES
        (1, '2023-09-30', 2),
        (2, '2023-09-30', 3),
        (3, '2023-09-29', 4),
        (4, '2023-09-29', 3),
        (5, '2023-09-28', 5);
    END IF;

    IF (SELECT COUNT(*) FROM public.TBL_PEDIDO) = 0 THEN
        INSERT INTO TBL_PRODUTOS_PEDIDO (ID_PEDIDO, ID_PRODUTO, QUANTIDADE) VALUES
        (1, 1, 1),  -- Pedido 1: Hambúrguer (Acompanhamento: Recebido)
        (2, 2, 2),  -- Pedido 2: Batata Frita (Acompanhamento: Em preparação)
        (3, 3, 1),  -- Pedido 3: Coca-Cola (Acompanhamento: Pronto)
        (4, 4, 3),  -- Pedido 4: Sundae de Chocolate (Acompanhamento: Em preparação)
        (5, 5, 2);  -- Pedido 5: Salada Caesar (Acompanhamento: Finalizado)	
    END IF;    
END $$;
