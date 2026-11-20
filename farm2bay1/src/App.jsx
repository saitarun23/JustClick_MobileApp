import { useCallback, useMemo, useState } from 'react'
import Splash from './components/Splash'
import Navbar from './components/Navbar'
import Hero from './components/Hero'
import Categories from './components/Categories'
import HowItWorks from './components/HowItWorks'
import Products from './components/Products'
import CartDrawer from './components/CartDrawer'
import Footer from './components/Footer'
import { categories, products } from './data/products'

export default function App() {
  const [showSplash, setShowSplash] = useState(true)
  const [cart, setCart] = useState({})
  const [cartOpen, setCartOpen] = useState(false)
  const [query, setQuery] = useState('')
  const [active, setActive] = useState('all')

  const finishSplash = useCallback(() => setShowSplash(false), [])

  const add = (id) => setCart((c) => ({ ...c, [id]: (c[id] || 0) + 1 }))
  const remove = (id) =>
    setCart((c) => {
      const next = { ...c }
      if (next[id] > 1) next[id] -= 1
      else delete next[id]
      return next
    })

  const count = Object.values(cart).reduce((a, b) => a + b, 0)

  const visible = useMemo(
    () =>
      products.filter(
        (p) =>
          (active === 'all' || p.category === active) &&
          p.name.toLowerCase().includes(query.toLowerCase())
      ),
    [active, query]
  )

  return (
    <>
      {showSplash && <Splash onDone={finishSplash} />}
      <div className={showSplash ? 'app' : 'app app--in'}>
        <Navbar query={query} setQuery={setQuery} count={count} openCart={() => setCartOpen(true)} />
        <Hero />
        <Categories categories={categories} active={active} setActive={setActive} />
        <HowItWorks />
        <Products
          items={visible}
          categories={categories}
          active={active}
          setActive={setActive}
          cart={cart}
          add={add}
          remove={remove}
        />
        <Footer />
        <CartDrawer
          open={cartOpen}
          close={() => setCartOpen(false)}
          products={products}
          cart={cart}
          add={add}
          remove={remove}
        />
      </div>
    </>
  )
}