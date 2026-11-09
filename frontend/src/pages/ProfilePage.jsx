import React from 'react';
import { User, MapPin, CreditCard, Clock, ShieldCheck, Heart, LogOut, ChevronRight } from 'lucide-react';

export default function ProfilePage({ currentLocation, onNavigate }) {
  return (
    <div className="max-w-4xl mx-auto space-y-6 animate-in fade-in duration-300">
      {/* Profile Header */}
      <div className="bg-white p-6 sm:p-8 rounded-3xl border border-slate-200/80 shadow-sm flex items-center gap-5">
        <div className="w-16 h-16 rounded-2xl bg-emerald-600 text-white flex items-center justify-center font-black text-2xl shadow-md">
          ST
        </div>
        <div className="flex-1">
          <h2 className="text-2xl font-black text-slate-900">Sai Tarun</h2>
          <p className="text-xs text-slate-500">tarun@freshcart.com • +1 (555) 234-5678</p>
          <div className="flex items-center gap-2 mt-2">
            <span className="text-[10px] font-extrabold uppercase bg-emerald-100 text-emerald-800 px-2.5 py-0.5 rounded-full">
              FreshCart Prime Member
            </span>
            <span className="text-[10px] font-bold bg-amber-100 text-amber-800 px-2.5 py-0.5 rounded-full">
              ⚡ Free Shipping Active
            </span>
          </div>
        </div>
      </div>

      {/* Account Control Sections */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        
        {/* Saved Addresses */}
        <div className="bg-white p-6 rounded-3xl border border-slate-200/80 shadow-sm space-y-4">
          <h3 className="text-sm font-extrabold uppercase tracking-wider text-slate-400 flex items-center gap-2">
            <MapPin className="w-4 h-4 text-emerald-600" />
            Delivery Addresses
          </h3>
          <div className="p-3.5 rounded-xl border border-emerald-500 bg-emerald-50/50 flex items-center justify-between">
            <div>
              <div className="font-bold text-xs text-slate-900">Home (Default)</div>
              <div className="text-[11px] text-slate-500">742 Evergreen Terrace, {currentLocation.city}</div>
            </div>
            <span className="text-[10px] font-bold text-emerald-700 bg-white px-2 py-0.5 rounded border border-emerald-200">Active</span>
          </div>
        </div>

        {/* Payment Methods & Wallet */}
        <div className="bg-white p-6 rounded-3xl border border-slate-200/80 shadow-sm space-y-4">
          <h3 className="text-sm font-extrabold uppercase tracking-wider text-slate-400 flex items-center gap-2">
            <CreditCard className="w-4 h-4 text-emerald-600" />
            FreshCart Wallet
          </h3>
          <div className="p-3.5 rounded-xl border border-slate-200 bg-slate-50 flex items-center justify-between">
            <div>
              <div className="font-bold text-xs text-slate-900">Wallet Balance</div>
              <div className="text-lg font-black text-emerald-950">$45.00</div>
            </div>
            <button className="bg-emerald-600 text-white text-xs font-bold px-3 py-1.5 rounded-lg">Add Cash</button>
          </div>
        </div>

      </div>

      {/* Quick Navigation Menu */}
      <div className="bg-white rounded-3xl border border-slate-200/80 shadow-sm divide-y divide-slate-100">
        <button onClick={() => onNavigate('orders')} className="w-full p-4 flex items-center justify-between hover:bg-slate-50 text-left transition-colors">
          <div className="flex items-center gap-3">
            <Clock className="w-5 h-5 text-emerald-600" />
            <span className="text-xs font-bold text-slate-800">Order History & Receipts</span>
          </div>
          <ChevronRight className="w-4 h-4 text-slate-400" />
        </button>

        <button onClick={() => onNavigate('wishlist')} className="w-full p-4 flex items-center justify-between hover:bg-slate-50 text-left transition-colors">
          <div className="flex items-center gap-3">
            <Heart className="w-5 h-5 text-rose-500" />
            <span className="text-xs font-bold text-slate-800">Saved Wishlist Items</span>
          </div>
          <ChevronRight className="w-4 h-4 text-slate-400" />
        </button>

        <button onClick={() => onNavigate('farms')} className="w-full p-4 flex items-center justify-between hover:bg-slate-50 text-left transition-colors">
          <div className="flex items-center gap-3">
            <ShieldCheck className="w-5 h-5 text-emerald-600" />
            <span className="text-xs font-bold text-slate-800">Local Eco-Farm Partners</span>
          </div>
          <ChevronRight className="w-4 h-4 text-slate-400" />
        </button>
      </div>
    </div>
  );
}