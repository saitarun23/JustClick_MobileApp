import { ArrowRight, Truck, Leaf, Milk, Carrot, Wheat, Citrus } from 'lucide-react'

function CrateArt() {
  return (
    <svg viewBox="0 0 420 340" className="crate-art" aria-hidden="true">
      {/* veggies */}
      <circle cx="205" cy="110" r="62" fill="#8bc34a" stroke="#174a37" strokeWidth="3" />
      <path d="M160 105 Q205 60 250 105 M170 135 Q205 95 240 135" stroke="#174a37" strokeWidth="3" fill="none" />
      <path d="M110 90 L150 160 L90 150 Z" fill="#f26b21" stroke="#174a37" strokeWidth="3" strokeLinejoin="round" />
      <path d="M105 90 Q100 60 112 48 M115 92 Q122 62 135 52" stroke="#4f8a12" strokeWidth="5" fill="none" strokeLinecap="round" />
      <ellipse cx="320" cy="140" rx="46" ry="26" fill="#6a3a8c" stroke="#174a37" strokeWidth="3" transform="rotate(-20 320 140)" />
      <path d="M268 120 q-14 -10 -6 -24 q14 4 18 20z" fill="#4f8a12" stroke="#174a37" strokeWidth="3" />
      <circle cx="150" cy="170" r="34" fill="#e53935" stroke="#174a37" strokeWidth="3" />
      <path d="M135 140 q15 -12 30 0" stroke="#4f8a12" strokeWidth="6" fill="none" strokeLinecap="round" />
      <rect x="235" y="150" width="46" height="62" rx="18" fill="#ffc107" stroke="#174a37" strokeWidth="3" />
      {/* crate */}
      {[190, 236, 282].map((y) => (
        <g key={y}>
          <rect x="40" y={y} width="340" height="40" rx="4" fill="#d28b45" stroke="#174a37" strokeWidth="3" />
          <path d={`M70 ${y + 14} Q200 ${y + 8} 350 ${y + 18}`} stroke="#a8652a" strokeWidth="2.5" fill="none" />
          <circle cx="58" cy={y + 20} r="4" fill="#174a37" />
          <circle cx="362" cy={y + 20} r="4" fill="#174a37" />
        </g>
      ))}
    </svg>
  )
}

export default function Hero() {
  return (
    <section id="home" className="hero">
      <Milk className="float f1" size={64} strokeWidth={1.2} />
      <Carrot className="float f2" size={64} strokeWidth={1.2} />
      <Wheat className="float f3" size={64} strokeWidth={1.2} />
      <Citrus className="float f4" size={64} strokeWidth={1.2} />
      <Leaf className="float f5" size={64} strokeWidth={1.2} />

      <div className="container hero__inner">
        <div className="hero__text">
          <span className="pill"><Truck size={16} /> Free delivery on your first order</span>
          <h1>Fresh from the <em>farm</em>,<br />straight to your door</h1>
          <p>
            Dairy, vegetables, pickles and powdered products sourced directly from
            farmers and delivered to your city within hours.
          </p>
          <div className="hero__cta">
            <a href="#products" className="btn btn--primary">Shop now <ArrowRight size={18} /></a>
            <a href="#how" className="btn btn--ghost">How it works</a>
          </div>
          <ul className="hero__stats">
            <li><strong>100%</strong><span>Farm sourced</span></li>
            <li><strong>2 hrs</strong><span>Average delivery</span></li>
            <li><strong>500+</strong><span>Local farmers</span></li>
          </ul>
        </div>
        <div className="hero__art"><CrateArt /></div>
      </div>
    </section>
  )
}