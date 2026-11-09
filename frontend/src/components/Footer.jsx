import React from 'react';
import { ShoppingBag, ShieldCheck, Truck, Clock, RefreshCw, Mail, ArrowRight } from 'lucide-react';

export default function Footer() {
  return (
    <footer className="bg-slate-900 text-slate-300 mt-16 pt-12 pb-8 border-t border-slate-800">
      <div className="max-w-7xl mx-auto px-4 lg:px-8">
        
        {/* Value Proposition Highlights */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 pb-12 border-b border-slate-800">
          <div className="flex items-center gap-3.5 bg-slate-800/60 p-4 rounded-2xl border border-slate-700/50">
            <div className="p-2.5 rounded-xl bg-emerald-500/10 text-emerald-400">
              <Clock className="w-6 h-6" />
            </div>
            <div>
              <h4 className="font-extrabold text-sm text-white">10-15 Min Dispatch</h4>
              <p className="text-xs text-slate-400">Packed fresh from local darkstores</p>
            </div>
          </div>

          <div className="flex items-center gap-3.5 bg-slate-800/60 p-4 rounded-2xl border border-slate-700/50">
            <div className="p-2.5 rounded-xl bg-emerald-500/10 text-emerald-400">
              <ShieldCheck className="w-6 h-6" />
            </div>
            <div>
              <h4 className="font-extrabold text-sm text-white">100% Eco-Certified</h4>
              <p className="text-xs text-slate-400">Directly from local family farms</p>
            </div>
          </div>

          <div className="flex items-center gap-3.5 bg-slate-800/60 p-4 rounded-2xl border border-slate-700/50">
            <div className="p-2.5 rounded-xl bg-emerald-500/10 text-emerald-400">
              <Truck className="w-6 h-6" />
            </div>
            <div>
              <h4 className="font-extrabold text-sm text-white">Cold-Chain Delivery</h4>
              <p className="text-xs text-slate-400">Insulated bags lock in freshness</p>
            </div>
          </div>

          <div className="flex items-center gap-3.5 bg-slate-800/60 p-4 rounded-2xl border border-slate-700/50">
            <div className="p-2.5 rounded-xl bg-emerald-500/10 text-emerald-400">
              <RefreshCw className="w-6 h-6" />
            </div>
            <div>
              <h4 className="font-extrabold text-sm text-white">Easy Refund Policy</h4>
              <p className="text-xs text-slate-400">Instant credit for any quality issue</p>
            </div>
          </div>
        </div>

        {/* Footer Main Content Grid */}
        <div className="grid grid-cols-1 md:grid-cols-5 gap-8 py-12 border-b border-slate-800">
          
          {/* Brand Column */}
          <div className="md:col-span-2 space-y-4">
            <div className="flex items-center gap-2.5">
              <div className="bg-emerald-600 text-white p-2 rounded-xl">
                <ShoppingBag className="w-6 h-6" />
              </div>
              <span className="font-extrabold text-2xl tracking-tight text-white">FreshCart</span>
              <span className="text-[10px] font-bold uppercase tracking-wider bg-emerald-500/20 text-emerald-400 px-2 py-0.5 rounded-full border border-emerald-500/30">
                Prime
              </span>
            </div>
            <p className="text-xs text-slate-400 max-w-sm leading-relaxed">
              Redefining quick-commerce with farm-to-table organic produce, artisanal bakery treats, and daily essentials delivered right to your kitchen in under 15 minutes.
            </p>
            
            {/* Newsletter Input */}
            <div className="pt-2">
              <span className="text-xs font-bold text-white block mb-2">Subscribe for weekly farm updates & promo codes</span>
              <div className="flex max-w-sm">
                <div className="relative flex-1">
                  <Mail className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
                  <input 
                    type="email" 
                    placeholder="Enter your email address..."
                    className="w-full bg-slate-800 border border-slate-700 text-xs text-white pl-9 pr-3 py-2.5 rounded-l-xl focus:outline-none focus:border-emerald-500"
                  />
                </div>
                <button className="bg-emerald-600 hover:bg-emerald-700 text-white px-4 text-xs font-bold rounded-r-xl transition-colors flex items-center gap-1">
                  <span>Join</span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </button>
              </div>
            </div>
          </div>

          {/* Quick Links */}
          <div>
            <h5 className="text-xs font-bold uppercase tracking-wider text-slate-400 mb-4">Categories</h5>
            <ul className="space-y-2 text-xs font-medium text-slate-300">
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Organic Fruits</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Farm Fresh Veggies</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">A2 Dairy & Pasture Eggs</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Artisan Sourdough & Breads</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Cold-Pressed Oils & Spices</li>
            </ul>
          </div>

          {/* Company Links */}
          <div>
            <h5 className="text-xs font-bold uppercase tracking-wider text-slate-400 mb-4">Company</h5>
            <ul className="space-y-2 text-xs font-medium text-slate-300">
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">About FreshCart</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Our Partner Eco-Farms</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Darkstore Hub Locations</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Sustainability & Impact</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Careers & Rider Network</li>
            </ul>
          </div>

          {/* Support Links */}
          <div>
            <h5 className="text-xs font-bold uppercase tracking-wider text-slate-400 mb-4">Customer Support</h5>
            <ul className="space-y-2 text-xs font-medium text-slate-300">
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Help Center & FAQ</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Track Your Order</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Refund & Return Policy</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Terms of Service</li>
              <li className="hover:text-emerald-400 cursor-pointer transition-colors">Privacy Policy</li>
            </ul>
          </div>

        </div>

        {/* Bottom Copyright Row */}
        <div className="pt-8 flex flex-col sm:flex-row items-center justify-between text-xs text-slate-500 gap-4">
          <p>© {new Date().getFullYear()} FreshCart Technologies Inc. All rights reserved.</p>
          <div className="flex items-center gap-6">
            <span className="hover:text-slate-400 cursor-pointer">Privacy</span>
            <span className="hover:text-slate-400 cursor-pointer">Terms</span>
            <span className="hover:text-slate-400 cursor-pointer">Cookies</span>
            <span className="hover:text-slate-400 cursor-pointer">Security</span>
          </div>
        </div>

      </div>
    </footer>
  );
}