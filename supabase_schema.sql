-- =========================================================
-- COMÉRCIO SAAS - SCHEMA MULTI-TENANT SUPABASE
-- =========================================================

-- 1. TABELA DE LOJAS / ESTABELECIMENTOS
CREATE TABLE IF NOT EXISTS public.lojas (
    id TEXT PRIMARY KEY, -- Slug da Loja (ex: 'pizzaria-do-ze', 'hamburgueria-artesanal')
    nome TEXT NOT NULL,
    nicho TEXT DEFAULT 'geral',
    logo_url TEXT DEFAULT 'watermarked_img_14074362198608020855.jpg',
    cor_tema TEXT DEFAULT '#C0392B',
    senha_admin TEXT DEFAULT '123456',
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. TABELA DE CONFIGURAÇÕES DA LOJA
CREATE TABLE IF NOT EXISTS public.loja_config (
    loja_id TEXT PRIMARY KEY REFERENCES public.lojas(id) ON DELETE CASCADE,
    whatsapp TEXT DEFAULT '',
    pix_key TEXT DEFAULT '',
    delivery_fee NUMERIC DEFAULT 5.00,
    hora_abertura TEXT DEFAULT '11:00',
    hora_fechamento TEXT DEFAULT '23:00',
    dias_funcionamento JSONB DEFAULT '["seg","ter","qua","qui","sex","sab","dom"]'::jsonb,
    status_modo TEXT DEFAULT 'auto',
    mensagem_fechado TEXT DEFAULT 'Estamos fechados no momento. Volte em breve!',
    evolution_api_url TEXT DEFAULT '',
    evolution_api_key TEXT DEFAULT '',
    evolution_instance TEXT DEFAULT '',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. TABELA DE CARDÁPIO / PRODUTOS
CREATE TABLE IF NOT EXISTS public.cardapio (
    loja_id TEXT NOT NULL REFERENCES public.lojas(id) ON DELETE CASCADE,
    id TEXT NOT NULL,
    categoria TEXT NOT NULL,
    nome TEXT NOT NULL,
    descricao TEXT DEFAULT '',
    tipo TEXT DEFAULT 'direct',
    preco NUMERIC DEFAULT 0,
    sizes JSONB DEFAULT '[]'::jsonb,
    misturas JSONB DEFAULT '[]'::jsonb,
    image TEXT DEFAULT '',
    disponivel BOOLEAN DEFAULT TRUE,
    ordem INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    PRIMARY KEY (loja_id, id)
);

-- 4. TABELA DE PEDIDOS
CREATE TABLE IF NOT EXISTS public.pedidos (
    id BIGSERIAL PRIMARY KEY,
    loja_id TEXT NOT NULL REFERENCES public.lojas(id) ON DELETE CASCADE,
    cliente_nome TEXT NOT NULL,
    cliente_telefone TEXT NOT NULL,
    tipo_entrega TEXT NOT NULL,
    endereco TEXT,
    complemento TEXT,
    itens JSONB NOT NULL,
    subtotal NUMERIC NOT NULL,
    taxa_entrega NUMERIC DEFAULT 0,
    total NUMERIC NOT NULL,
    forma_pagamento TEXT NOT NULL,
    troco_para TEXT,
    status TEXT DEFAULT 'pendente',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ÍNDICES DE ALTA PERFORMANCE
CREATE INDEX IF NOT EXISTS idx_cardapio_loja_id ON public.cardapio(loja_id);
CREATE INDEX IF NOT EXISTS idx_pedidos_loja_id ON public.pedidos(loja_id);
CREATE INDEX IF NOT EXISTS idx_pedidos_created_at ON public.pedidos(created_at);

-- ROW LEVEL SECURITY (RLS)
ALTER TABLE public.lojas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.loja_config ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cardapio ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pedidos ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public full access lojas" ON public.lojas;
CREATE POLICY "Public full access lojas" ON public.lojas FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Public full access loja_config" ON public.loja_config;
CREATE POLICY "Public full access loja_config" ON public.loja_config FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Public full access cardapio" ON public.cardapio;
CREATE POLICY "Public full access cardapio" ON public.cardapio FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Public full access pedidos" ON public.pedidos;
CREATE POLICY "Public full access pedidos" ON public.pedidos FOR ALL USING (true) WITH CHECK (true);

-- SUPABASE REALTIME
ALTER PUBLICATION supabase_realtime ADD TABLE public.lojas;
ALTER PUBLICATION supabase_realtime ADD TABLE public.loja_config;
ALTER PUBLICATION supabase_realtime ADD TABLE public.cardapio;
ALTER PUBLICATION supabase_realtime ADD TABLE public.pedidos;
