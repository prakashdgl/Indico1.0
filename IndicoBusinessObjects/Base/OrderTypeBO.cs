// This file is generated by CodeSmith. Do not edit. All edits to this file will be lost. 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Xml.Serialization;

using Indico.DAL;

//namespace Indico.BusinessObjects
namespace Indico.BusinessObjects
{
    /// <summary>
    /// 
    /// </summary>
    public partial class OrderTypeBO : BusinessObject, IComparable
    {
        #region fields
        #region Scalar Fields
        private int id;
        private string _description = string.Empty;
        private string _name = string.Empty;
        #endregion
        
        #region Foreign Key fields
        #endregion
        
        #region Foreign Table Foreign Key fields
        [NonSerialized][XmlIgnoreAttribute]
        private IndicoList<Indico.BusinessObjects.OrderDetailBO> orderDetailsWhereThisIsOrderTypeList;
        [NonSerialized][XmlIgnoreAttribute]
        private bool _orderDetailsWhereThisIsOrderTypeLoaded;
        #endregion
        
        #region Other fields
        
        private Indico.DAL.OrderType _objDAL = null;
        private bool _doNotUpdateDALObject = false;
        
        #endregion
        
        #endregion
        
        #region Properties
        /// <summary>The Primary Key for this object</summary>
        public int ID
        {   get {return id;}
            set 
            {
                OnIDChanging(value);
                id = value;
                OnIDChanged();
            }
        }
        
        /// <summary>The description of the order type. The maximum length of this property is 512.</summary>
        public string Description
        {   
            get {return _description;}
            set 
            {
                OnDescriptionChanging(value);
                _description = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Description = value;
                }
                OnDescriptionChanged();
            }
        }
        /// <summary>The name of the order type. The maximum length of this property is 64.</summary>
        public string Name
        {   
            get {return _name;}
            set 
            {
                OnNameChanging(value);
                _name = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Name = value;
                }
                OnNameChanged();
            }
        }
        
        internal Indico.DAL.OrderType ObjDAL
        {
            get 
            {
                if (_objDAL == null && base._createDAL)
                {
                    _objDAL = this.SetDAL(this.Context.Context);
                    this.ObjDAL.PropertyChanged += new System.ComponentModel.PropertyChangedEventHandler(obj_PropertyChanged);
                }

                return _objDAL;
            }
            set 
            {
                _objDAL = value;
            }
        }
        
        #endregion
        
        #region Non-scalar Properties
        
        #region Foreign Key Objects
        #endregion
        
        #region Foreign Object Foreign Key Collections
        [XmlIgnoreAttribute]
        public IndicoList<Indico.BusinessObjects.OrderDetailBO> OrderDetailsWhereThisIsOrderType // FK_OrderDetail_OrderType
        {
            get
            {
                if (!_orderDetailsWhereThisIsOrderTypeLoaded)
                {
                    _orderDetailsWhereThisIsOrderTypeLoaded = true;
                    if (this.ID > 0)
                    {
                         IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
                        Indico.DAL.OrderType obj = (from o in context.OrderType
                                     where o.ID == this.ID
                                     select o).FirstOrDefault();

                        obj.OrderDetailsWhereThisIsOrderType.Load();
                        orderDetailsWhereThisIsOrderTypeList = new IndicoList<Indico.BusinessObjects.OrderDetailBO>(obj.OrderDetailsWhereThisIsOrderType.Count);
                        
                        foreach (Indico.DAL.OrderDetail o in obj.OrderDetailsWhereThisIsOrderType)
                        {
                            Indico.BusinessObjects.OrderDetailBO fkObj = new Indico.BusinessObjects.OrderDetailBO(o, ref this._context);
                            orderDetailsWhereThisIsOrderTypeList.Add(fkObj);
                        }
                        
                        if (this.Context == null)
                        {
                            context.Dispose();
                        }
                    }
                    else
                    {
                        orderDetailsWhereThisIsOrderTypeList = new IndicoList<Indico.BusinessObjects.OrderDetailBO>();
                    }
                    
                    orderDetailsWhereThisIsOrderTypeList.OnBeforeRemove += new EventHandler(OrderDetailsWhereThisIsOrderTypeList_OnBeforeRemove);
                    orderDetailsWhereThisIsOrderTypeList.OnAfterAdd += new EventHandler(OrderDetailsWhereThisIsOrderTypeList_OnAfterAdd);
                }
                
                return orderDetailsWhereThisIsOrderTypeList;
            }
        }
        #endregion
        
        #endregion
        
        #region Internal Constructors
        /// <summary>
        /// Creates an instance of the OrderTypeBO class using the supplied Indico.DAL.OrderType. 
        /// </summary>
        /// <param name="obj">a Indico.DAL.OrderType whose properties will be used to initialise the OrderTypeBO</param>
        internal OrderTypeBO(Indico.DAL.OrderType obj, ref IndicoContext context)
        {
            this._doNotUpdateDALObject = true;
            
            this.Context = context;
        
            // set the properties from the Indico.DAL.OrderType 
            this.ID = obj.ID;
            
            this.Description = obj.Description;
            this.Name = obj.Name;
            
            this._doNotUpdateDALObject = false;
        }
        #endregion
        
        #region Internal utility methods
        internal Indico.DAL.OrderType SetDAL(IndicoEntities context)
        {
            this._doNotUpdateDALObject = true;
        
            // set the Indico.DAL.OrderType properties
            Indico.DAL.OrderType obj = new Indico.DAL.OrderType();
            
            if (this.ID > 0)
            {
                obj = context.OrderType.FirstOrDefault<OrderType>(o => o.ID == this.ID);
            }
            
            obj.Description = this.Description;
            obj.Name = this.Name;
            
            
            if (_orderDetailsWhereThisIsOrderTypeLoaded)
                BusinessObject.SynchroniseEntityList(
                    Indico.BusinessObjects.OrderDetailBO.ToEntityList(this.OrderDetailsWhereThisIsOrderType, context), 
                    obj.OrderDetailsWhereThisIsOrderType);
            
            this._doNotUpdateDALObject = false;
            
            return obj;
        }
        
        internal void SetBO(System.Data.Objects.DataClasses.EntityObject eObj)
        {
            this._doNotUpdateDALObject = true;
            
            // Check the received type
            if (eObj.GetType() != typeof(Indico.DAL.OrderType))
            {
                throw new FormatException("Received wrong parameter type...");
            }

            Indico.DAL.OrderType obj = (Indico.DAL.OrderType)eObj;
            
            // set the Indico.BusinessObjects.OrderTypeBO properties
            this.ID = obj.ID;
            
            this.Description = obj.Description;
            this.Name = obj.Name;
            
            
            this._doNotUpdateDALObject = false;
        }
        
        internal void SetBO(Indico.BusinessObjects.OrderTypeBO obj)
        {
            this._doNotUpdateDALObject = true;
            
            // set this Indico.BusinessObjects.OrderTypeBO properties
            this.ID = obj.ID;
            
            this.Description = obj.Description;
            this.Name = obj.Name;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal List<Indico.BusinessObjects.OrderTypeBO> IQueryableToList(IQueryable<Indico.DAL.OrderType> oQuery)
        {
            List<Indico.DAL.OrderType> oList = oQuery.ToList();
            List<Indico.BusinessObjects.OrderTypeBO> rList = new List<Indico.BusinessObjects.OrderTypeBO>(oList.Count);
            foreach (Indico.DAL.OrderType o in oList)
            {
                Indico.BusinessObjects.OrderTypeBO obj = new Indico.BusinessObjects.OrderTypeBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal List<Indico.BusinessObjects.OrderTypeBO> ToList(IEnumerable<Indico.DAL.OrderType> oQuery)
        {
            List<Indico.DAL.OrderType> oList = oQuery.ToList();
            List<Indico.BusinessObjects.OrderTypeBO> rList = new List<Indico.BusinessObjects.OrderTypeBO>(oList.Count);
            foreach (Indico.DAL.OrderType o in oList)
            {
                Indico.BusinessObjects.OrderTypeBO obj = new Indico.BusinessObjects.OrderTypeBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal static List<Indico.DAL.OrderType> ToEntityList(List<OrderTypeBO> bos, IndicoEntities context)
        {
            // build a List of OrderType entities from the business objects
            List<Int32> ids = (from o in bos
                                   select o.ID).ToList<Int32>();

            return (context.OrderType.Count() == 0) ? new List<Indico.DAL.OrderType>() : (context.OrderType.Where(BuildContainsExpression<OrderType, int>(e => e.ID, ids)))
                .ToList<Indico.DAL.OrderType>();
        }
        
        internal static System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.OrderType> ToEntityCollection(List<OrderTypeBO> bos, IndicoEntities context)
        {
            // build an EntityCollection of OrderType entities from the business objects
            List<Int32> ids = (from o in bos
                               select o.ID).ToList<Int32>();

            List<Indico.DAL.OrderType> el = (context.OrderType.Count() == 0) ? new List<Indico.DAL.OrderType>() : 
                context.OrderType.Where(BuildContainsExpression<OrderType, int>(e => e.ID, ids))
                .ToList<Indico.DAL.OrderType>();
                
            System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.OrderType> ec 
                = new System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.OrderType>();
                
            foreach (Indico.DAL.OrderType r in el) 
            {
                ec.Add(r);
            }
            return ec;
        }

        internal Indico.DAL.OrderType ToEntity(IndicoEntities context)
        {
            return (from o in context.OrderType
                    where o.ID == this.ID
                    select o).FirstOrDefault();
        }
        #endregion
        
        #region BusinessObject methods
        
        #region Add Object
        
        public void Add()
        {
            if (this.Context != null)
            {
                this.Context.Context.AddToOrderType(this.ObjDAL);
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.OrderType obj = this.SetDAL(objContext.Context);
                objContext.Context.AddToOrderType(obj);
                objContext.SaveChanges();
                objContext.Dispose(); 
            }
        }
        
        #endregion
        
        #region Delete Object
        
        public void Delete()
        {
            if (this.Context != null)
            {
                if (this.ObjDAL != null && this.ObjDAL.EntityKey != null)
                {
                    if (this.ObjDAL.EntityState == System.Data.EntityState.Detached)
                    {
                        this.Context.Context.Attach(this.ObjDAL);
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                    else
                    {
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                }
                else
                {
                    Indico.DAL.OrderType obj = this.SetDAL(this.Context.Context);
                    this.Context.Context.DeleteObject(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.OrderType obj = this.SetDAL(objContext.Context);
                this.Context.Context.DeleteObject(obj);
                objContext.Context.SaveChanges();
                objContext.Dispose();
            }
        }
        
        #endregion
        
        #region Get Single Object
        
        public bool GetObject()
        {
            return GetObject(true);
        }
        public bool GetObject(bool blnCache)
        {
            Indico.BusinessObjects.OrderTypeBO data = null;
            
            if (blnCache)
            {
                data = this.GetFromCache(this.ID) as Indico.BusinessObjects.OrderTypeBO; 
            }

            if (data != null)
            {
                SetBO(data);
            }
            else
            {
                try
                {
                    IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
                    IQueryable<Indico.DAL.OrderType> oQuery =
                        from o in context.OrderType
                        where o.ID == this.ID
                        select o;

                    List<Indico.DAL.OrderType> oList = oQuery.ToList();
                    if (oList.Count != 1)
                        return false;
                    else
                    {
                        SetBO(oList[0]);
                        this.Cache();
                    }
                    
                    if (this.Context == null)
                    {
                        context.Dispose();
                    }
                }
                catch (System.Exception e)
                {
                    throw new IndicoException(String.Format(System.Globalization.CultureInfo.InvariantCulture, ResourceManager.GetString("Could not Retrieve a {0} from the data store", System.Globalization.CultureInfo.CurrentCulture), this.ToString()), e, IndicoException.Severities.USER, IndicoException.ERRNO.INT_ERR_BO_SELECT_FAIL);
                }
            }
            return true;
        }
        #endregion
        
        #region GetAllObject
        public List<Indico.BusinessObjects.OrderTypeBO> GetAllObject()
        {
            return GetAllObject(0, 0);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> GetAllObject(int maximumRows)
        {
            return GetAllObject(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> GetAllObject(int maximumRows, int startIndex)
        {
            return GetAllObject(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> GetAllObject(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.OrderType> oQuery =
                (from o in context.OrderType
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.OrderTypeBO> ordertypes = IQueryableToList(oQuery);
            context.Dispose();
            return ordertypes;
        }
        #endregion
        
        #region SearchObjects
        public List<Indico.BusinessObjects.OrderTypeBO> SearchObjects()
        {
            return SearchObjects(0,0);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> SearchObjects(int maximumRows)
        {
            return SearchObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> SearchObjects(int maximumRows, int startIndex)
        {
            return SearchObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> SearchObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.OrderType> oQuery =
                (from o in context.OrderType
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.Name == string.Empty || this.Name == o.Name) &&
                    (this.Description == string.Empty || this.Description == o.Description) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.OrderTypeBO> ordertypes = IQueryableToList(oQuery);
            
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return ordertypes;
        }
        
        public int SearchObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.OrderType
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.Name == string.Empty || this.Name == o.Name) &&
                    (this.Description == string.Empty || this.Description == o.Description) 
                 orderby o.ID
                 select o).Count();
        }
        #endregion
        
        #region SearchObjectsLikeAnd
        public List<Indico.BusinessObjects.OrderTypeBO> SearchLikeAndObjects()
        {
            return SearchLikeAndObjects(0);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> SearchLikeAndObjects(int maximumRows)
        {
            return SearchLikeAndObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> SearchLikeAndObjects(int maximumRows, int startIndex)
        {
            return SearchLikeAndObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> SearchLikeAndObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.OrderType> oQuery =
                (from o in context.OrderType
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.Name == string.Empty || o.Name.Contains(this.Name)) &&
                    (this.Description == string.Empty || o.Description.Contains(this.Description)) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.OrderTypeBO> ordertypes = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return ordertypes;
        }
        
        public int SearchLikeAndObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.OrderType
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.Name == string.Empty || o.Name.Contains(this.Name)) &&
                    (this.Description == string.Empty || o.Description.Contains(this.Description)) 
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region SearchObjectsLikeOr
        public List<Indico.BusinessObjects.OrderTypeBO> SearchLikeOrObjects()
        {
            return SearchLikeOrObjects(0);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> SearchLikeOrObjects(int maximumRows)
        {
            return SearchLikeOrObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> SearchLikeOrObjects(int maximumRows, int startIndex)
        {
            return SearchLikeOrObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.OrderTypeBO> SearchLikeOrObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.OrderType> oQuery =
                (from o in context.OrderType
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    ((o.Name.Contains(this.Name)) ||
                    (o.Description.Contains(this.Description)) ||
                    (this.Name == null && this.Description == null ))
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.OrderTypeBO> ordertypes = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return ordertypes;
        }
        
        public int SearchLikeOrObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.OrderType
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    ((o.Name.Contains(this.Name)) ||
                    (o.Description.Contains(this.Description)) ||
                    (this.Name == null && this.Description == null ))
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region Serialization methods
        /// <summary>
        /// Serializes the Indico.BusinessObjects.OrderTypeBO to an XML representation
        /// </summary>
        /// <returns>a XML string serialized representation</returns>
        public string SerializeObject()
        {
            string strReturn = "";

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            x.Serialize(objStream, this);

            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            // Read string from binary file with UTF8 encoding
            strReturn = encoding.GetString(objStream.GetBuffer());

            objStream.Close();
            return strReturn;

        }

        /// <summary>
        /// Deserializes Indico.BusinessObjects.OrderTypeBO object from an XML representation
        /// </summary>
        /// <param name="strXML">a XML string serialized representation</param>
        public Indico.BusinessObjects.OrderTypeBO DeserializeObject(string strXML)
        {
            Indico.BusinessObjects.OrderTypeBO objTemp = null;
            System.Xml.XmlDocument objXML = new System.Xml.XmlDocument();

            objXML.LoadXml(strXML);
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();
            byte[] b = encoding.GetBytes(objXML.OuterXml);

            objStream.Write(b, 0, (int)b.Length);
            objStream.Position = 0;
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            objTemp = (Indico.BusinessObjects.OrderTypeBO)x.Deserialize(objStream);
            objStream.Close();
            return objTemp;
        }

        /// <summary>
        /// Returns a simple XML representation of Indico.BusinessObjects.OrderTypeBO object in an XmlElement
        /// </summary>
        /// <returns>An XML snippet representing the object</returns>
        public string ToXmlString()
        {
            // MW TODO - implement this better.
            return SerializeObject();
        }
        #endregion
        
        #region OnPropertyChange Methods
        partial void OnIDChanged()
        {
            OnOrderTypeBOIDChanged();
        }
        
        partial void OnIDChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("OrderTypeBO.ID must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnOrderTypeBOIDChanging(value);
        }
        partial void OnIDChanged();
        partial void OnIDChanging(int value);
        partial void OnOrderTypeBOIDChanged();
        partial void OnOrderTypeBOIDChanging(int value);
        
        partial void OnNameChanged()
        {
            OnOrderTypeBONameChanged();
        }
        
        partial void OnNameChanging(string value)
        {
            if (value != null && value.Length > 64)
            {
                throw new Exception(String.Format("OrderTypeBO.Name has a maximum length of 64. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnOrderTypeBONameChanging(value);
        }
        partial void OnNameChanged();
        partial void OnNameChanging(string value);
        partial void OnOrderTypeBONameChanged();
        partial void OnOrderTypeBONameChanging(string value);
        
        partial void OnDescriptionChanged()
        {
            OnOrderTypeBODescriptionChanged();
        }
        
        partial void OnDescriptionChanging(string value)
        {
            if (value != null && value.Length > 512)
            {
                throw new Exception(String.Format("OrderTypeBO.Description has a maximum length of 512. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnOrderTypeBODescriptionChanging(value);
        }
        partial void OnDescriptionChanged();
        partial void OnDescriptionChanging(string value);
        partial void OnOrderTypeBODescriptionChanged();
        partial void OnOrderTypeBODescriptionChanging(string value);
        
        #endregion
        
        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (!(obj is Indico.BusinessObjects.OrderTypeBO))
                return 1;
            Indico.BusinessObjects.OrderTypeBOComparer c = new Indico.BusinessObjects.OrderTypeBOComparer();
            return c.Compare(this, obj as Indico.BusinessObjects.OrderTypeBO);
        }

        #endregion
        #endregion
        
        #region Events
        
        void obj_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "ID")
            {
                // reload me
                this.SetBO((Indico.DAL.OrderType)sender);
            }
        }
        
        void OrderDetailsWhereThisIsOrderTypeList_OnAfterAdd(object sender, EventArgs e)
        {
            Indico.DAL.OrderDetail obj = null;
            if (this.Context != null)
            {
                if (((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender).Count > 0)
                {
                    obj = ((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender)[((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender).Count - 1].ObjDAL;
                    this.ObjDAL.OrderDetailsWhereThisIsOrderType.Add(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                obj = ((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender)[((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender).Count - 1].SetDAL(objContext.Context);
                this.ObjDAL.OrderDetailsWhereThisIsOrderType.Add(obj);
                objContext.SaveChanges();
                objContext.Dispose();
            }
        }
        
        void OrderDetailsWhereThisIsOrderTypeList_OnBeforeRemove(object sender, EventArgs e)
        {
            Indico.DAL.OrderDetail obj = null;
            if (this.Context != null)
            {
                if (((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender).Count > 0)
                {
                    obj = ((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender)[((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender).Count - 1].ObjDAL;
                    this.ObjDAL.OrderDetailsWhereThisIsOrderType.Remove(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                obj = ((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender)[((IndicoList<Indico.BusinessObjects.OrderDetailBO>)sender).Count - 1].SetDAL(objContext.Context);
                this.ObjDAL.OrderDetailsWhereThisIsOrderType.Remove(obj);
                objContext.SaveChanges();
                objContext.Dispose();
            }
        }
        
        void Context_OnSendBeforeChanges(object sender, EventArgs e)
        {        
            this._orderDetailsWhereThisIsOrderTypeLoaded = false;
            if (this.orderDetailsWhereThisIsOrderTypeList != null)
            {
                this.orderDetailsWhereThisIsOrderTypeList.OnBeforeRemove -= new EventHandler(OrderDetailsWhereThisIsOrderTypeList_OnBeforeRemove);
                this.orderDetailsWhereThisIsOrderTypeList.OnAfterAdd -= new EventHandler(OrderDetailsWhereThisIsOrderTypeList_OnAfterAdd);
            }
        }
        
        void Context_OnSendAfterChanges(object sender, EventArgs e)
        {   
            if (this.ID > 0)
            {
                this.Cache();
            }
        }

        #endregion
    }
    
    #region OrderTypeBOComparer
    public class OrderTypeBOComparer : IComparer<Indico.BusinessObjects.OrderTypeBO>
    {
        private string propertyToCompareName;
        public OrderTypeBOComparer(string propertyToCompare)
        {
            PropertyInfo p = typeof(Indico.BusinessObjects.OrderTypeBO).GetProperty(propertyToCompare);
            if (p == null)
                throw new ArgumentException("is not a public property of Indico.BusinessObjects.OrderTypeBO", "propertyToCompare");
            this.propertyToCompareName = propertyToCompare;
        }
        
        public OrderTypeBOComparer()
        {
        
        }

        #region IComparer<Indico.BusinessObjects.OrderTypeBO> Members
        public int Compare(Indico.BusinessObjects.OrderTypeBO x, Indico.BusinessObjects.OrderTypeBO y)
        {
            if (propertyToCompareName != null)
            {
                PropertyInfo p = typeof(Indico.BusinessObjects.OrderTypeBO).GetProperty(propertyToCompareName);
                return compare(p, x, y);
            }
            else
            {
                PropertyInfo[] arrP = typeof(Indico.BusinessObjects.OrderTypeBO).GetProperties();
                foreach (PropertyInfo p in arrP)
                {
                    int v = compare(p, x, y);
                    if (v != 0)
                        return v;
                }
                return 0;
            }
        }

        private int compare(PropertyInfo p, Indico.BusinessObjects.OrderTypeBO x, Indico.BusinessObjects.OrderTypeBO y)
        {
            object xVal = p.GetValue(x, null);
            object yVal = p.GetValue(y, null);

            if (xVal == null)
            {
                if (yVal == null)
                    return 0;
                else
                    return -1; // x is null, y is not, y is greater
            }
            else
            {
                if (y == null)
                    return 1; // x non null, y is null, x is greater
                else if (xVal is string)
                {
                    return StringComparer.OrdinalIgnoreCase.Compare(xVal, yVal);
                }
                else if (xVal is IComparable)
                {
                    return ((IComparable)xVal).CompareTo((IComparable)yVal);
                }
                else
                    throw new ArgumentException
                        ("is not string or valuetype that implements IComparable", "propertyToCompare");

            }
        }

        #endregion
    }
    #endregion
}
