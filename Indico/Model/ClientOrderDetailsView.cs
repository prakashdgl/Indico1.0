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
    
    public partial class ClientOrderDetailsView
    {
        public int OrderDetailId { get; set; }
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public int OrderId { get; set; }
        public System.DateTime Date { get; set; }
        public System.DateTime DesiredDeliveryDate { get; set; }
        public string OrderNumber { get; set; }
        public bool IsTemporary { get; set; }
        public int ClientId { get; set; }
        public string ClientName { get; set; }
        public int OrderTypeId { get; set; }
        public string OrderType { get; set; }
        public int VisualLayoutId { get; set; }
        public string NamePrefix { get; set; }
        public Nullable<int> NameSuffix { get; set; }
        public int PatternId { get; set; }
        public string PatternNumber { get; set; }
        public int FabricId { get; set; }
        public string Fabric { get; set; }
        public string FabricNickName { get; set; }
        public int StatusId { get; set; }
        public string Status { get; set; }
    }
}
