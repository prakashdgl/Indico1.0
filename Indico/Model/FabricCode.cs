//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Indico.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class FabricCode
    {
        public FabricCode()
        {
            this.ArtWorks = new HashSet<ArtWork>();
            this.CostSheets = new HashSet<CostSheet>();
            this.OrderDetails = new HashSet<OrderDetail>();
            this.PatternSupportFabrics = new HashSet<PatternSupportFabric>();
            this.Prices = new HashSet<Price>();
            this.QuoteDetails = new HashSet<QuoteDetail>();
            this.VisualLayouts = new HashSet<VisualLayout>();
            this.VisualLayoutFabrics = new HashSet<VisualLayoutFabric>();
        }
    
        public int ID { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Material { get; set; }
        public string GSM { get; set; }
        public Nullable<int> Supplier { get; set; }
        public int Country { get; set; }
        public string DenierCount { get; set; }
        public string Filaments { get; set; }
        public string NickName { get; set; }
        public string SerialOrder { get; set; }
        public Nullable<decimal> FabricPrice { get; set; }
        public Nullable<int> LandedCurrency { get; set; }
        public string Fabricwidth { get; set; }
        public Nullable<int> Unit { get; set; }
        public Nullable<int> FabricColor { get; set; }
        public bool IsActive { get; set; }
        public bool IsPure { get; set; }
        public bool IsLiningFabric { get; set; }
    
        public virtual AccessoryColor AccessoryColor { get; set; }
        public virtual ICollection<ArtWork> ArtWorks { get; set; }
        public virtual ICollection<CostSheet> CostSheets { get; set; }
        public virtual Country Country1 { get; set; }
        public virtual Currency Currency { get; set; }
        public virtual Supplier Supplier1 { get; set; }
        public virtual Unit Unit1 { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
        public virtual ICollection<PatternSupportFabric> PatternSupportFabrics { get; set; }
        public virtual ICollection<Price> Prices { get; set; }
        public virtual ICollection<QuoteDetail> QuoteDetails { get; set; }
        public virtual ICollection<VisualLayout> VisualLayouts { get; set; }
        public virtual ICollection<VisualLayoutFabric> VisualLayoutFabrics { get; set; }
    }
}
