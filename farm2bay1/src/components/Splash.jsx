import { useEffect, useState } from 'react'
import { Leaf, Sprout, Truck as TruckIcon, Store } from 'lucide-react'
import './splash/splash.css'
import Truck from './splash/Truck'
import { SceneDefs, CloudLayer, FarLayer, MidLayer, NearLayer, ForeLayer } from './splash/Scene'

export default function Splash({ onDone }) {
  const [leaving, setLeaving] = useState(false)

  useEffect(() => {
    const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches
    const t1 = setTimeout(() => setLeaving(true), reduce ? 700 : 8800)
    const t2 = setTimeout(onDone, reduce ? 1300 : 9600)
    return () => {
      clearTimeout(t1)
      clearTimeout(t2)
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
      <div className="sp-bar sp-bar--top" />
      <div className="sp-bar sp-bar--bottom" />

      <header className="sp-brand">
        <span className="sp-brand__mark"><Leaf size={30} strokeWidth={2.2} /></span>
        <h1>farm2bay</h1>
        <p>Farm fresh, delivered to your city</p>
      </header>

      <div className="sp-hud">
        <div className="sp-caps">
          <span className="sp-cap sp-cap--1"><Sprout size={18} /> Harvested fresh at the farm</span>
          <span className="sp-cap sp-cap--2"><TruckIcon size={18} /> Packed and on the road</span>
          <span className="sp-cap sp-cap--3"><Store size={18} /> Delivered to your city</span>
        </div>

        <div className="sp-route">
          <div className="sp-route__line"><span className="sp-route__fill" /></div>
          <div className="sp-node sp-node--1"><span className="sp-node__dot"><Sprout size={18} /></span><small>Farm</small></div>
          <div className="sp-node sp-node--2"><span className="sp-node__dot"><TruckIcon size={18} /></span><small>On the road</small></div>
          <div className="sp-node sp-node--3"><span className="sp-node__dot"><Store size={18} /></span><small>Your city</small></div>
        </div>
      </div>
    </div>
  )
}