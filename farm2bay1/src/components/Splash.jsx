import { useEffect, useState } from 'react'
import { Leaf } from 'lucide-react'
import './splash/splash.css'
import Truck from './splash/Truck'
import { SceneDefs, CloudLayer, FarLayer, MidLayer, NearLayer, ForeLayer } from './splash/Scene'

export default function Splash({ onDone }) {
  const [leaving, setLeaving] = useState(false)

  useEffect(() => {
    const prevBody = document.body.style.overflow
    const prevHtml = document.documentElement.style.overflow
    document.body.style.overflow = 'hidden'
    document.documentElement.style.overflow = 'hidden'

    const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches
    const t1 = setTimeout(() => setLeaving(true), reduce ? 700 : 8800)
    const t2 = setTimeout(onDone, reduce ? 1300 : 9600)

    return () => {
      clearTimeout(t1)
      clearTimeout(t2)
      document.body.style.overflow = prevBody
      document.documentElement.style.overflow = prevHtml
    }
  }, [onDone])

  return (
    <div className={`sp ${leaving ? 'sp--leave' : ''}`} role="status" aria-label="Loading farm2bay">
      <div className="sp-sky">
        <div className="sp-sky__day" />
        <div className="sp-sun" />
      </div>

      <SceneDefs />
      <CloudLayer />
      <FarLayer />
      <MidLayer />
      <NearLayer />
      <Truck />
      <ForeLayer />

      <div className="sp-tint" />
      <div className="sp-vignette" />

      <header className="sp-brand">
        <span className="sp-brand__mark"><Leaf size={30} strokeWidth={2.2} /></span>
        <h1>farm2bay</h1>
      </header>
    </div>
  )
}